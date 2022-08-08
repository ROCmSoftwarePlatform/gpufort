! SPDX-License-Identifier: MIT
! Copyright (c) 2020-2022 Advanced Micro Devices, Inc. All rights reserved.
!> All type definitions must match those in `gpufortrt_types.h`.
module types
  integer, parameter :: gpufortrt_async_noval = -1 
  integer,parameter  :: gpufortrt_handle_kind = c_int
  
  !> Mapping kinds.
  enum, bind(c)
    enumerator :: gpufortrt_map_kind_undefined       = 0
    enumerator :: gpufortrt_map_kind_present         = 1
    enumerator :: gpufortrt_map_kind_delete          = 2
    enumerator :: gpufortrt_map_kind_create          = 3
    enumerator :: gpufortrt_map_kind_no_create       = 4
    enumerator :: gpufortrt_map_kind_copyin          = 5
    enumerator :: gpufortrt_map_kind_copyout         = 6
    enumerator :: gpufortrt_map_kind_copy            = 7
  end enum
  
  enum, bind(c)
    enumerator :: gpufortrt_counter_none       = 0
    enumerator :: gpufortrt_counter_structured = 1
    enumerator :: gpufortrt_counter_dynamic    = 2
  end enum
  
  type, bind(c) :: gpufortrt_mapping_t
    type(c_ptr) :: hostptr   = c_null_ptr
    integer(c_size_t) :: num_bytes =  0
    integer(kind(gpufortrt_map_kind_undefined)) :: map_kind = gpufortrt_map_kind_undefined
    logical(c_bool) :: never_deallocate = .false.
  end type

contains

  subroutine gpufortrt_mapping_init(mapping,hostptr,num_bytes,map_kind,never_deallocate)
    use iso_c_binding
    use gpufortrt_auxiliary
    implicit none
    !
    type(gpufortrt_mapping_init),intent(inout) :: mapping
    type(c_ptr),intent(in) :: hostptr
    integer(c_size_t),intent(in) :: num_bytes
    integer(kind(gpufortrt_map_kind_undefined)),intent(in) :: map_kind
    logical,intent(in),optional :: never_deallocate
    !
    mapping%hostptr    = hostptr
    mapping%num_bytes  = num_bytes
    mapping%map_kind   = map_kind
    mapping%never_deallocate = logical(eval_optval(never_deallocate,.false._c_bool),&
                                       kind=c_bool)
  end subroutine

end module