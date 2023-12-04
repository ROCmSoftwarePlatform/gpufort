// SPDX-License-Identifier: MIT
// Copyright (c) 2020-2022 Advanced Micro Devices, Inc. All rights reserved.
#include "gpufort.h"
#include "gpufort_array.h"

#include <assert.h>

#include "test_gpufort_array_kernels.hip.cpp"

void test1() {
  gpufort::array1<int> int_array1;
  gpufort::array2<int> int_array2;
  gpufort::array3<int> int_array3;

  HIP_CHECK(int_array1.init(sizeof(int),nullptr,nullptr, 10, -1, 
     gpufort::AllocMode::AllocPinnedHostAllocDevice)); // hostptr,devptr, count, lower bound, alloc_mode
  HIP_CHECK(int_array2.init(sizeof(int),nullptr,nullptr, 10,10, -1,-2, 
      gpufort::AllocMode::AllocHostAllocDevice));
  HIP_CHECK(int_array3.init(sizeof(int),nullptr,nullptr, 10,10,10, -1,-2,-3,
      gpufort::AllocMode::AllocPinnedHostAllocDevice));

  assert(  10==int_array1.data.num_elements);
  assert( 100==int_array2.data.num_elements);
  assert(1000==int_array3.data.num_elements);
  
  assert(  1==int_array1.data.index_offset);
  assert( 21==int_array2.data.index_offset);
  assert(321==int_array3.data.index_offset);
  
  assert(0==int_array1.linearized_index(-1));
  assert(0==int_array2.linearized_index(-1,-2));
  assert(0==int_array3.linearized_index(-1,-2,-3));

  assert(  9==int_array1.linearized_index(-1+10-1)); // upper bound
  assert( 99==int_array2.linearized_index(-1+10-1,-2+10-1));
  assert(999==int_array3.linearized_index(-1+10-1,-2+10-1,-3+10-1));

  launch_fill_int_array_1(int_array1);
  launch_fill_int_array_2(int_array2);
  launch_fill_int_array_3(int_array3);

  HIP_CHECK(int_array1.copy_to_host()); 
  HIP_CHECK(int_array2.copy_to_host()); 
  HIP_CHECK(int_array3.copy_to_host()); 
  
  HIP_CHECK(hipDeviceSynchronize());

  for (int n = 0; n < int_array1.data.num_elements; n++ ) {
    //std::cout << int_array1.data.data_host[n] << std::endl; 
    assert(int_array1.data.data_host[n] == n);
  } 
  for (int n = 0; n < int_array2.data.num_elements; n++ ) {
    assert(int_array2.data.data_host[n] == n);
  } 
  for (int n = 0; n < int_array3.data.num_elements; n++ ) {
    assert(int_array3.data.data_host[n] == n);
  } 
}

void test2() {
  gpufort::array3<bool>   bool_array;
  gpufort::array3<short>  short_array;
  gpufort::array3<char>   char_array;
  gpufort::array3<int>    int_array;
  gpufort::array3<long>   long_array;
  gpufort::array3<float>  float_array;
  gpufort::array3<double> double_array;
  assert(sizeof(bool_array)==sizeof(short_array));
  assert(sizeof(char_array)==sizeof(short_array));
  assert(sizeof(char_array)==sizeof(int_array));
  assert(sizeof(long_array)==sizeof(int_array));
  assert(sizeof(long_array)==sizeof(float_array));
  assert(sizeof(double_array)==sizeof(float_array));
}

int main(int argc,char** argv) {
  test1();
  test2();
  std::cout << "PASSED" << std::endl;
  return 0;
}