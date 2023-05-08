// SPDX-License-Identifier: MIT
// Copyright (c) 2020-2022 Advanced Micro Devices, Inc. All rights reserved.
#ifndef GPUFORTRT_TYPES_H
#define GPUFORTRT_TYPES_H

#include "hip/hip_runtime_api.h"

#ifdef __cplusplus
extern "C" {
#endif
  /**
   * \note: Enum values must match those of Fortran enumeration!
   * \note: Upper case first letter used because `delete` is C++ keyword.
   */
  enum gpufortrt_map_kind_t {
    gpufortrt_map_kind_undefined = 0,
    gpufortrt_map_kind_present   = 1,
    gpufortrt_map_kind_delete    = 2,
    gpufortrt_map_kind_create    = 3,
    gpufortrt_map_kind_no_create = 4,
    gpufortrt_map_kind_copyin    = 5,
    gpufortrt_map_kind_copyout   = 6,
    gpufortrt_map_kind_copy      = 7
  };
  
  /**
   * Reference counter type.
   * \note: Data layout must match that of Fortran `gpufortrt_counter_t` type!
   */
  enum gpufortrt_counter_t {
    gpufortrt_counter_none = 0,
    gpufortrt_counter_structured = 1,
    gpufortrt_counter_dynamic = 2
  };

  struct gpufortrt_mapping_t {
    void* hostptr                 = nullptr;
    std::size_t num_bytes              = 0;
    gpufortrt_map_kind_t map_kind = gpufortrt_map_kind_undefined;
    bool never_deallocate         = false;
  };
    
  void gpufortrt_mapping_init(
    gpufortrt_mapping_t* mapping,
    void* hostptr,
    std::size_t num_bytes,
    gpufortrt_map_kind_t map_kind,
    bool never_deallocate);
    
  typedef hipStream_t gpufortrt_queue_t;
  extern gpufortrt_queue_t gpufortrt_default_queue;
#ifdef __cplusplus
} // extern "C"

std::ostream& operator<<(std::ostream& os, gpufortrt_map_kind_t map_kind);
std::ostream& operator<<(std::ostream& os, gpufortrt_counter_t counter);
std::ostream& operator<<(std::ostream& os,const gpufortrt_mapping_t& mapping);
#endif
#endif // GPUFORTRT_TYPES_H