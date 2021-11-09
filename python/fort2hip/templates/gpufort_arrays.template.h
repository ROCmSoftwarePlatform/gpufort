{# SPDX-License-Identifier: MIT                                                 #}
{# Copyright (c) 2021 Advanced Micro Devices, Inc. All rights reserved. #}
{%- macro separated_list_single_line(prefix,sep,rank) -%}
{% for d in range(1,rank+1) -%}
{{prefix}}{{d}}{{ sep if not loop.last }}{%- endfor %}
{%- endmacro -%}
{%- macro separated_list(prefix,sep,rank) -%}
{% for d in range(1,rank+1) -%}
{{prefix}}{{d}}{{ sep+"\n" if not loop.last }}
{%- endfor %}
{%- endmacro -%}
{%- macro arglist(prefix,rank) -%}
{{ separated_list(prefix,",",rank) }}
{%- endmacro -%}
{%- macro bound_args(prefix,rank) -%}
{{ arglist(prefix+"n",rank) }},
{{ arglist(prefix+"lb",rank) }}
{%- endmacro -%}
// This file was generated from a template via gpufort --gpufort-create-headers
#ifndef _GPUFORT_ARRAYS_H_
#define _GPUFORT_ARRAYS_H_
#include <hip/hip_runtime_api.h>
#ifndef _GPUFORT_H_
#include <iostream>
#include <stdlib.h>
#define HIP_CHECK(condition)         \
  {                                  \
    hipError_t error = condition;    \
    if(error != hipSuccess){         \
        std::cout << "HIP error: " << error << " line: " << __LINE__ << std::endl; \
        exit(error); \
    } \
  }
#endif
namespace gpufort {
{% for rank in range(1,max_rank+1) %}
{% set rank_ub = rank+1 %}
  /**
   * Intended to be passed as kernel launch parameter.
   */
  template<typename T>
  struct GpuArray{{rank}} {
    T* data_host        = nullptr;
    T* data_dev         = nullptr;
    size_t num_elements = 0;     //> Number of represented by this array.
    int    index_offset = -1;    //> Offset for index calculation; scalar product of negative lower bounds and strides.
{% for d in range(1,rank_ub) %}
    size_t stride{{d}}  = -1; //> Strides for linearizing {{rank}}-dimensional index.
{% endfor %}
 
    /**
     * Wrap a host-device pointer pair and store the associated
     * array meta data.
     *
     * \param[in] data_host host data pointer.
     * \param[in] data_dev device data pointer.
     * \param[in] n1,n2,... element counts per dimension of the multi-dim. array 
     * \param[in] lb1,lb2,... lower bounds, i.e. the index of the first element per dimension of the multi-dim. array 
     */ 
    __host__ __device__ void wrap(
        T* data_host,
        T* data_dev,
{{ bound_args("int ",rank) | indent(8,True) }}
      ) {
       this->data_host = data_host;
       this->data_dev  = data_dev;
       // column-major access
       this->num_elements = {{ separated_list_single_line("n","*",rank) }};
{% for d in range(1,rank_ub) %}
       this->stride{{d}}  = 1{%- for e in range(1,d) -%}*n{{e}}{%- endfor %};
{% endfor %}
       this->index_offset =
{% for d in range(1,rank_ub) %}
         -lb{{d}}*this->stride{{d}}{{";" if loop.last}}
{% endfor %}
    }
    
    /**
     * Linearize multi-dimensional index.
     *
     * \param[in] i1,i2,... multi-dimensional array index.
     */
    __host__ __device__ __forceinline__ int linearized_index (
{{ arglist("const int i",rank) | indent(6,"True") }}
    ) {
      return this->index_offset
{% for d in range(1,rank_ub) %}
          + i{{d}}*this->stride{{d}}
{% endfor %}
      ;
    }
    
    /**
     * \return Element at given index.
     * \param[in] i1,i2,... multi-dimensional array index.
     */
    __host__ __device__ __forceinline__ T& operator() (
{{ arglist("const int i",rank) | indent(6,"True") }}
    ) {
      const int index = linearized_index(
{{ separated_list_single_line("i",",",rank) | indent(8,"True") }}
      );
      #if __HIP_DEVICE_COMPILE__
      return this->data_dev[index];
      #else
      return this->data_host[index];
      #endif
    }
  };

  template<typename T>
  struct MappedArray{{rank}}{
    GpuArray{{rank}}<T> data;
    hipStream_t stream          = nullptr;
    bool pinned                 = false; //> If the host data is pinned. 
    bool copyout_at_destruction = false; //> If the device data should be copied back to the host when this struct is destroyed.
    bool owns_host_data         = false; //> If this is only a wrapper, i.e. no memory management is performed.
    bool owns_device_data       = false; //> If this is only a wrapper, i.e. no memory management is performed.
    int ref_ctr                 = 0;     //> Number of references.
   
    /**
     * Initialize.
     * \param[in] data_host host data pointer (may be nullptr; see the note).
     * \param[in] pinned the host array is pinned or should be pinned.
     * \param[in] copyout_at_destruction copy data out from the
     *            device to the host when this instance gets destroyed.
     * \note Allocates a new host_data pointer if the
     * passed pointer is a nullptr. If the pinned argument is true,
     * the new hostpotr is allocated via hipHostMalloc.
     * Otherwise, it is allocated via classic malloc.
     */
    __host__ hipError_t init(
        T* data_host,
        T* data_dev,
{{ bound_args("int ",rank) | indent(8,True) }},
        bool pinned,
        hipStream_t stream          = nullptr,
        bool copyout_at_destruction = false) {
      hipError_t ierr = hipSuccess;
      this->data.wrap(
          data_host,
          data_dev,
{{ bound_args("",rank) | indent(10,True) }}
      );
      this->stream                 = stream;
      this->pinned                 = pinned;
      this->copyout_at_destruction = copyout_at_destruction; 
      this->owns_host_data         = data_host == nullptr;
      this->owns_device_data       = data_dev == nullptr;
      if ( this->owns_host_data && pinned ) {
        ierr = hipHostMalloc((void**) &this->data.data_host,this->num_data_bytes(),0);
      } else if ( this->owns_host_data ) {
        this->data.data_host = (T*) malloc(this->num_data_bytes());
      }
      if ( ierr == hipSuccess && this->owns_device_data ) {
        ierr = hipMalloc((void**) &this->data.data_dev, this->num_data_bytes());
      } 
      return ierr;
    }

    MappedArray{{rank}}() {
      // do nothing
    }
    
    ~MappedArray{{rank}}() {
      HIP_CHECK(this->destroy());
    }

    /**
     * Destroy associated host and device data
     * if this is not a wrapper. Depending
     * on the pinned attribue, hipHostFree 
     * is used instead of free to deallocate
     * the host data.
     */
    __host__ hipError_t destroy() {
      hipError_t ierr = hipSuccess;
      #ifndef __HIP_DEVICE_COMPILE__
      if ( this->owns_host_data && this->data.data_host != nullptr ) {
        if ( this->pinned ) {
          ierr = hipHostFree(this->data.data_host);
        } else {
          free(this->data.data_host); 
        }
      }
      if ( ierr == hipSuccess ) {
        if ( this->owns_device_data && this->data.data_dev != nullptr ) {
          ierr = hipFree(this->data.data_dev);
        }
      }
      #endif
      return ierr;
    }
    
    __host__ size_t num_data_bytes() {
      return this->data.num_elements * sizeof(T);
    }
 
    /**
     * Copy host data to the device.
     * \return Array code returned by the underlying hipMemcpy operation.
     */
    __host__ hipError_t copy_data_to_host() {
      return hipMemcpyAsync(
        (void*) this->data.data_host, 
        (void*) this->data.data_dev,
        this->num_data_bytes(), 
	hipMemcpyDeviceToHost,this->stream);
    }
    
    /**
     * Copy device data to the host.
     * \return Array code returned by the underlying hipMemcpy operation.
     */
    __host__ hipError_t copy_data_to_device() {
      return hipMemcpyAsync(
        (void*) this->data.data_dev, 
        (void*) this->data.data_host,
        this->num_data_bytes(), 
        hipMemcpyHostToDevice,this->stream);
    }

    /** 
     * Copies the struct to the device but
     * does not touch the data associated with 
     * data_dev & data_host (shallow copy).
     * \param[inout] device_copy pointer to device copy pointer 
     */
    __host__ hipError_t create_device_copy(void** device_copy) {
      const size_t size = sizeof(MappedArray{{rank}}<T>);
      hipError_t ierr = hipMalloc(device_copy,size);
      if ( ierr == hipSuccess ) {
        ierr =  hipMemcpyH2DAsync(
          (void*) *device_copy, 
          (void*) this,
          size, this->stream);
      }
      return ierr;
    }
    
    /**
     * \return Element at given index.
     * \param[in] i1,i2,... multi-dimensional array index.
     */
    __host__ T& operator() (
{{ arglist("const int i",rank) | indent(6,"True") }}
    ) {
      return this->data(
{{ separated_list_single_line("i",",",rank) | indent(8,"True") }}
      );
    }
  };
{{ "" if not loop.last }}
{% endfor -%}
}
#endif // _GPUFORT_ARRAYS_H_  