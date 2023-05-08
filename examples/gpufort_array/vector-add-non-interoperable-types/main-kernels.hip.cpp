// SPDX-License-Identifier: MIT
// Copyright (c) 2020-2022 Advanced Micro Devices, Inc. All rights reserved.
// This file was generated by gpufort
#ifndef __KERNELS_HIP_CPP__
#define __KERNELS_HIP_CPP__
#include "hip/hip_runtime.h"
#include "hip/hip_complex.h"
#include "gpufort.h"
#include "gpufort_array.h"

// C++ structs with same layout as Fortran interop types
struct node_t {
  float val;
};

struct mesh_t {
  float a;
  gpufort::array1<node_t> x; 
  gpufort::array1<float> y;
};

/*
   HIP C++ implementation of the function/loop body of:

     !$cuf kernel do(1) <<<grid, tBlock>>>
     do i=1,size(mesh%y,1)
       mesh%y(i) = mesh%y(i) + mesh%a*mesh%x(i)%val
     end do
*/

__global__ void  vecadd_kernel(mesh_t mesh) {
  int i = 1 + (1)*(threadIdx.x + blockIdx.x * blockDim.x);
  if (loop_cond(i,mesh.y.size(1),1)) {
    mesh.y(i)= mesh.y(i) + mesh.a*mesh.x(i).val;
  }
}

extern "C" void launch_vecadd_kernel_auto_(
    const int& sharedmem, 
    hipStream_t& stream,
    mesh_t& mesh
) {
  const int vecadd_kernel_blockX = 128;
  dim3 block(vecadd_kernel_blockX);
  const int vecadd_kernel_NX = (1 + ((mesh.y.size(1)) - (1)));
  const int vecadd_kernel_gridX = divideAndRoundUp( vecadd_kernel_NX, vecadd_kernel_blockX );
  dim3 grid(vecadd_kernel_gridX);
   
  // launch kernel
  hipLaunchKernelGGL((vecadd_kernel), grid, block, sharedmem, stream, mesh);
}
#endif // __KERNELS_HIP_CPP__ 