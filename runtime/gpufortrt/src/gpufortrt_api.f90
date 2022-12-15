! SPDX-License-Identifier: MIT
! Copyright (c) 2020-2022 Advanced Micro Devices, Inc. All rights reserved.
module gpufortrt_api
  use gpufortrt_types

  interface
    subroutine gpufortrt_init() bind(c,name="gpufortrt_init")
      implicit none
    end subroutine
  
    subroutine gpufortrt_shutdown() bind(c,name="gpufortrt_shutdown")
      implicit none
    end subroutine
  
    function gpufortrt_get_stream(async_arg) &
        bind(c,name="gpufortrt_get_stream") &
          result(stream)
      use iso_c_binding, only: c_ptr
      use gpufortrt_types, only: gpufortrt_handle_kind
      implicit none
      integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
      !
      type(c_ptr) :: stream
    end function
  end interface
   
  interface gpufortrt_present
    module procedure :: gpufortrt_present_b
    module procedure :: gpufortrt_present_nb
  end interface

  interface gpufortrt_use_device
    module procedure :: gpufortrt_use_device0_l1
    module procedure :: gpufortrt_use_device0_l4
    module procedure :: gpufortrt_use_device0_ch1
    module procedure :: gpufortrt_use_device0_i1
    module procedure :: gpufortrt_use_device0_i2
    module procedure :: gpufortrt_use_device0_i4
    module procedure :: gpufortrt_use_device0_i8
    module procedure :: gpufortrt_use_device0_r4
    module procedure :: gpufortrt_use_device0_r8
    module procedure :: gpufortrt_use_device0_c4
    module procedure :: gpufortrt_use_device0_c8
    module procedure :: gpufortrt_use_device1_l1
    module procedure :: gpufortrt_use_device1_l4
    module procedure :: gpufortrt_use_device1_ch1
    module procedure :: gpufortrt_use_device1_i1
    module procedure :: gpufortrt_use_device1_i2
    module procedure :: gpufortrt_use_device1_i4
    module procedure :: gpufortrt_use_device1_i8
    module procedure :: gpufortrt_use_device1_r4
    module procedure :: gpufortrt_use_device1_r8
    module procedure :: gpufortrt_use_device1_c4
    module procedure :: gpufortrt_use_device1_c8
    module procedure :: gpufortrt_use_device2_l1
    module procedure :: gpufortrt_use_device2_l4
    module procedure :: gpufortrt_use_device2_ch1
    module procedure :: gpufortrt_use_device2_i1
    module procedure :: gpufortrt_use_device2_i2
    module procedure :: gpufortrt_use_device2_i4
    module procedure :: gpufortrt_use_device2_i8
    module procedure :: gpufortrt_use_device2_r4
    module procedure :: gpufortrt_use_device2_r8
    module procedure :: gpufortrt_use_device2_c4
    module procedure :: gpufortrt_use_device2_c8
    module procedure :: gpufortrt_use_device3_l1
    module procedure :: gpufortrt_use_device3_l4
    module procedure :: gpufortrt_use_device3_ch1
    module procedure :: gpufortrt_use_device3_i1
    module procedure :: gpufortrt_use_device3_i2
    module procedure :: gpufortrt_use_device3_i4
    module procedure :: gpufortrt_use_device3_i8
    module procedure :: gpufortrt_use_device3_r4
    module procedure :: gpufortrt_use_device3_r8
    module procedure :: gpufortrt_use_device3_c4
    module procedure :: gpufortrt_use_device3_c8
    module procedure :: gpufortrt_use_device4_l1
    module procedure :: gpufortrt_use_device4_l4
    module procedure :: gpufortrt_use_device4_ch1
    module procedure :: gpufortrt_use_device4_i1
    module procedure :: gpufortrt_use_device4_i2
    module procedure :: gpufortrt_use_device4_i4
    module procedure :: gpufortrt_use_device4_i8
    module procedure :: gpufortrt_use_device4_r4
    module procedure :: gpufortrt_use_device4_r8
    module procedure :: gpufortrt_use_device4_c4
    module procedure :: gpufortrt_use_device4_c8
    module procedure :: gpufortrt_use_device5_l1
    module procedure :: gpufortrt_use_device5_l4
    module procedure :: gpufortrt_use_device5_ch1
    module procedure :: gpufortrt_use_device5_i1
    module procedure :: gpufortrt_use_device5_i2
    module procedure :: gpufortrt_use_device5_i4
    module procedure :: gpufortrt_use_device5_i8
    module procedure :: gpufortrt_use_device5_r4
    module procedure :: gpufortrt_use_device5_r8
    module procedure :: gpufortrt_use_device5_c4
    module procedure :: gpufortrt_use_device5_c8
    module procedure :: gpufortrt_use_device6_l1
    module procedure :: gpufortrt_use_device6_l4
    module procedure :: gpufortrt_use_device6_ch1
    module procedure :: gpufortrt_use_device6_i1
    module procedure :: gpufortrt_use_device6_i2
    module procedure :: gpufortrt_use_device6_i4
    module procedure :: gpufortrt_use_device6_i8
    module procedure :: gpufortrt_use_device6_r4
    module procedure :: gpufortrt_use_device6_r8
    module procedure :: gpufortrt_use_device6_c4
    module procedure :: gpufortrt_use_device6_c8
    module procedure :: gpufortrt_use_device7_l1
    module procedure :: gpufortrt_use_device7_l4
    module procedure :: gpufortrt_use_device7_ch1
    module procedure :: gpufortrt_use_device7_i1
    module procedure :: gpufortrt_use_device7_i2
    module procedure :: gpufortrt_use_device7_i4
    module procedure :: gpufortrt_use_device7_i8
    module procedure :: gpufortrt_use_device7_r4
    module procedure :: gpufortrt_use_device7_r8
    module procedure :: gpufortrt_use_device7_c4
    module procedure :: gpufortrt_use_device7_c8
  end interface

contains
  
  type(c_ptr) function gpufortrt_deviceptr(hostptr) 
    use iso_c_binding
    implicit none
    !
    type(*), dimension(..), target, intent(in) :: hostptr
    !
    interface 
    type(c_ptr) function gpufortrt_deviceptr_c_impl(hostptr) &
      bind(c,name="gpufortrt_deviceptr") 
      use iso_c_binding
      implicit none
      !
      type(c_ptr),value,intent(in) :: hostptr
    end function
    end interface
    !
    gpufortrt_deviceptr = gpufortrt_deviceptr_c_impl(c_loc(hostptr))
  end function

  type(c_ptr) function gpufortrt_present_b(hostptr,num_bytes) 
    use iso_c_binding
    implicit none
    !
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t), value,intent(in) :: num_bytes
    !
    interface 
    type(c_ptr) function gpufortrt_present_b_c_impl(hostptr,num_bytes) &
      bind(c,name="gpufortrt_present") 
      use iso_c_binding
      implicit none
      !
      type(c_ptr), value::hostptr
      integer(c_size_t), value :: num_bytes
    end function
    end interface 
    gpufortrt_present_b = gpufortrt_present_b_c_impl(c_loc(hostptr),int(num_bytes,kind=c_size_t))
  end function

  type(c_ptr) function gpufortrt_present_nb(hostptr)
    use iso_c_binding
    implicit none
    !
    type(*), target, dimension(..), contiguous :: hostptr
    gpufortrt_present_nb = gpufortrt_present_b(c_loc(hostptr),int(sizeof(hostptr), kind = c_size_t))
  end function

  !> Ignore the result of a mapping routine.
  !> \param[in] deviceptr a device pointer.
  subroutine gpufortrt_ignore(deviceptr)
    use iso_c_binding, only: c_ptr
    implicit none
    type(c_ptr),intent(in) :: deviceptr
    ! nop
  end subroutine

  subroutine gpufortrt_wait(wait_arg,async_arg,condition)
    use iso_c_binding
    implicit none
    integer(gpufortrt_handle_kind),dimension(:),target,intent(in),optional :: wait_arg,async_arg
    logical,intent(in),optional :: condition
    !
    interface
      subroutine gpufortrt_wait_all_c_impl(condition) &
          bind(c,name="gpufortrt_wait_all")
        use iso_c_binding
        implicit none
        logical(c_bool),value,intent(in):: condition 
      end subroutine
      subroutine gpufortrt_wait_all_async_c_impl(async_arg,num_async_args,condition) &
          bind(c,name="gpufortrt_wait_all_async")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: async_arg
        integer(c_int),value,intent(in) :: num_async_args
        logical(c_bool),value,intent(in) :: condition 
      end subroutine
      subroutine gpufortrt_wait_c_impl(wait_arg,num_wait_args,condition) &
          bind(c,name="gpufortrt_wait")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: wait_arg
        integer(c_int),value,intent(in) :: num_wait_args
        logical(c_bool),value,intent(in) :: condition 
      end subroutine
      subroutine gpufortrt_wait_async_c_impl(wait_arg,num_wait_args,&
                                             async_arg,num_async_args,&
                                             condition) &
          bind(c,name="gpufortrt_wait_async")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: wait_arg, async_arg
        integer(c_int),value,intent(in) :: num_wait_args, num_async_args
        logical(c_bool),value,intent(in) :: condition 
      end subroutine
    end interface
    !
    logical(c_bool) :: opt_if_arg
    !
    opt_if_arg = .true._c_bool
    if ( present(condition) ) opt_if_arg = logical(condition,kind=c_bool)
    !
    if ( present(wait_arg) ) then
      if ( present(async_arg) ) then
        call gpufortrt_wait_async_c_impl(&
             c_loc(wait_arg),size(wait_arg,kind=c_int),&
             c_loc(async_arg),size(async_arg,kind=c_int),&
             opt_if_arg)
      else
        call gpufortrt_wait_c_impl(&
             c_loc(wait_arg),size(wait_arg,kind=c_int),&
             opt_if_arg)
      endif
    else
      if ( present(async_arg) ) then
        call gpufortrt_wait_all_async_c_impl(&
             c_loc(async_arg),size(async_arg,kind=c_int),&
             opt_if_arg)
      else
        call gpufortrt_wait_all_c_impl(opt_if_arg)
      endif
    endif
  end subroutine

  subroutine gpufortrt_data_start(mappings,async_arg)
  !subroutine gpufortrt_data_start(device_kind,mappings,async_arg)
    use iso_c_binding
    implicit none
    !integer,intent(in) :: device_kind
    type(gpufortrt_mapping_t),dimension(:),target,intent(in),optional :: mappings
    integer(gpufortrt_handle_kind),intent(in),optional :: async_arg
    !
    interface
      subroutine gpufortrt_data_start_c_impl(mappings,num_mappings) bind(c,name="gpufortrt_data_start")
        use iso_c_binding
        implicit none
        type(c_ptr),intent(in),value :: mappings
        integer(c_int),intent(in),value :: num_mappings
      end subroutine
      subroutine gpufortrt_data_start_async_c_impl(mappings,num_mappings,async_arg) bind(c,name="gpufortrt_data_start_async")
        use iso_c_binding
        use gpufortrt_types, only: gpufortrt_handle_kind
        implicit none
        type(c_ptr),intent(in),value :: mappings
        integer(c_int),intent(in),value :: num_mappings
        integer(gpufortrt_handle_kind),intent(in),value :: async_arg
      end subroutine
    end interface 
    !
    if ( present(async_arg) ) then
      if ( present(mappings) ) then
        call gpufortrt_data_start_async_c_impl(c_loc(mappings),size(mappings),&
                                               int(async_arg,kind=c_int))
      else
        call gpufortrt_data_start_async_c_impl(c_null_ptr,0_c_int,&
                                               int(async_arg,kind=c_int)) 
      endif
    else
      if ( present(mappings) ) then
        call gpufortrt_data_start_c_impl(c_loc(mappings),size(mappings))  
      else
        call gpufortrt_data_start_c_impl(c_null_ptr,0_c_int)  
      endif
    endif
  end subroutine
   
  subroutine gpufortrt_data_end(async_arg)
    implicit none
    integer(gpufortrt_handle_kind),intent(in),optional :: async_arg
    !
    interface
      subroutine gpufortrt_data_end_c_impl() bind(c,name="gpufortrt_data_end")
        use iso_c_binding
        use gpufortrt_types, only: gpufortrt_handle_kind
        implicit none
      end subroutine
      subroutine gpufortrt_data_end_async_c_impl(async_arg) bind(c,name="gpufortrt_data_end_async")
        use iso_c_binding
        use gpufortrt_types, only: gpufortrt_handle_kind
        implicit none
        integer(gpufortrt_handle_kind),intent(in),value :: async_arg
      end subroutine
    end interface 
    !
    if ( present(async_arg) ) then
      call gpufortrt_data_end_async_c_impl(async_arg)  
    else
      call gpufortrt_data_end_c_impl()  
    endif
  end subroutine

  subroutine gpufortrt_enter_exit_data(mappings,async_arg,finalize)
    use iso_c_binding
    implicit none
    !
    !integer,intent(in) :: device_kind
    type(gpufortrt_mapping_t),dimension(:),target,intent(in),optional :: mappings
    integer(gpufortrt_handle_kind),intent(in),optional :: async_arg
    logical,intent(in),optional :: finalize
    !
    interface
      subroutine gpufortrt_enter_exit_data_c_impl(mappings,num_mappings,finalize) bind(c,name="gpufortrt_enter_exit_data")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: mappings
        integer(c_int),value,intent(in) :: num_mappings
        logical(c_bool),value,intent(in) :: finalize
      end subroutine
      subroutine gpufortrt_enter_exit_data_async_c_impl(mappings,num_mappings,async_arg,finalize) bind(c,name="gpufortrt_enter_exit_data_async")
        use iso_c_binding
        use gpufortrt_types, only: gpufortrt_handle_kind
        implicit none
        type(c_ptr),value,intent(in) :: mappings
        integer(c_int),value,intent(in) :: num_mappings
        integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
        logical(c_bool),value,intent(in) :: finalize
      end subroutine
    end interface 
    !
    logical(c_bool) :: opt_finalize
    !
    opt_finalize = .false._c_bool
    if ( present(finalize) ) opt_finalize = logical(finalize,kind=c_bool)
    !
    if ( present(async_arg) ) then
      if ( present(mappings) ) then
        call gpufortrt_enter_exit_data_async_c_impl(&
          c_loc(mappings),&
          size(mappings,kind=c_int),&
          async_arg,&
          opt_finalize) 
      else
        call gpufortrt_enter_exit_data_async_c_impl(&
          c_null_ptr,&
          0_c_int,&
          async_arg,&
          opt_finalize) 
      endif
    else
      if ( present(mappings) ) then
        call gpufortrt_enter_exit_data_c_impl(&
          c_loc(mappings),&
          size(mappings,kind=c_int),&
          opt_finalize) 
      else
        call gpufortrt_enter_exit_data_c_impl(&
          c_null_ptr,&
          0_c_int,&
          opt_finalize) 
      endif
    endif
  end subroutine

  !> Lookup device pointer for given host pointer.
  !> \param[in] condition condition that must be met, otherwise host pointer is returned. Defaults to '.true.'.
  !> \param[in] if_present Only return device pointer if one could be found for the host pointer.
  !>                       otherwise host pointer is returned. Defaults to '.false.'.
  !> \note Returns a c_null_ptr if the host pointer is invalid, i.e. not C associated.
  function gpufortrt_use_device_b(hostptr,condition,if_present) result(resultptr)
    use iso_c_binding
    implicit none
    type(c_ptr),intent(in) :: hostptr
    logical,intent(in),optional :: condition, if_present
    !
    type(c_ptr) :: resultptr
    !
    interface
      function gpufortrt_use_device_c_impl(hostptr,condition,if_present) &
          bind(c,name="gpufortrt_use_device") result(deviceptr)
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        logical(c_bool),value,intent(in) :: condition, if_present
        !
        type(c_ptr) :: deviceptr
      end function
    end interface
    !
    logical(c_bool) :: opt_if_arg, opt_if_present_arg
    !
    opt_if_arg = .true._c_bool
    opt_if_present_arg = .false._c_bool
    if ( present(condition) ) opt_if_arg = logical(condition,kind=c_bool)
    if ( present(if_present) ) opt_if_present_arg = logical(if_present,kind=c_bool)
    !
    resultptr = gpufortrt_use_device_c_impl(hostptr,opt_if_arg,opt_if_present_arg)
  end function

  
  subroutine gpufortrt_use_device0_l1(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical(c_bool),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical(c_bool),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_l1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical(c_bool),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical(c_bool),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_l1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical(c_bool),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical(c_bool),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_l1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical(c_bool),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical(c_bool),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_l1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical(c_bool),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical(c_bool),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_l1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical(c_bool),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical(c_bool),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_l1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical(c_bool),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical(c_bool),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_l1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical(c_bool),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical(c_bool),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_l4(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical,target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical,pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_l4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical,target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical,pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_l4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical,target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical,pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_l4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical,target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical,pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_l4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical,target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical,pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_l4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical,target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical,pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_l4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical,target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical,pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_l4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    logical,target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    logical,pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_ch1(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    character(c_char),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    character(c_char),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_ch1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    character(c_char),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    character(c_char),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_ch1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    character(c_char),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    character(c_char),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_ch1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    character(c_char),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    character(c_char),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_ch1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    character(c_char),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    character(c_char),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_ch1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    character(c_char),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    character(c_char),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_ch1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    character(c_char),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    character(c_char),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_ch1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    character(c_char),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    character(c_char),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_i1(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int8_t),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int8_t),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_i1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int8_t),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int8_t),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_i1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int8_t),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int8_t),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_i1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int8_t),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int8_t),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_i1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int8_t),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int8_t),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_i1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int8_t),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int8_t),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_i1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int8_t),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int8_t),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_i1(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int8_t),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int8_t),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_i2(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_short),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_short),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_i2(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_short),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_short),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_i2(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_short),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_short),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_i2(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_short),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_short),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_i2(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_short),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_short),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_i2(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_short),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_short),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_i2(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_short),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_short),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_i2(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_short),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_short),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_i4(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_i4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_i4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_i4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_i4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_i4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_i4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_i4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_int),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_int),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_i8(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_long),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_long),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_i8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_long),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_long),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_i8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_long),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_long),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_i8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_long),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_long),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_i8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_long),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_long),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_i8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_long),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_long),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_i8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_long),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_long),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_i8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    integer(c_long),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    integer(c_long),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_r4(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_float),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_float),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_r4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_float),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_float),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_r4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_float),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_float),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_r4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_float),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_float),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_r4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_float),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_float),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_r4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_float),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_float),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_r4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_float),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_float),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_r4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_float),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_float),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_r8(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_double),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_double),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_r8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_double),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_double),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_r8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_double),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_double),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_r8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_double),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_double),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_r8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_double),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_double),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_r8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_double),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_double),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_r8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_double),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_double),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_r8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    real(c_double),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    real(c_double),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_c4(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_float_complex),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_float_complex),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_c4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_float_complex),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_float_complex),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_c4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_float_complex),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_float_complex),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_c4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_float_complex),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_float_complex),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_c4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_float_complex),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_float_complex),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_c4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_float_complex),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_float_complex),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_c4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_float_complex),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_float_complex),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_c4(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_float_complex),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_float_complex),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device0_c8(resultptr,hostptr,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_double_complex),target,intent(in) :: hostptr
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_double_complex),pointer,intent(inout) :: resultptr
    !
    type(c_ptr) :: tmp_cptr
    !
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr)
  end subroutine

  subroutine gpufortrt_use_device1_c8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_double_complex),target,intent(in) :: hostptr(*)
    integer,intent(in),optional :: sizes(1), lbounds(1)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_double_complex),pointer,intent(inout) :: resultptr(:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(1), opt_lbounds(1)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device2_c8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_double_complex),target,intent(in) :: hostptr(1:1,*)
    integer,intent(in),optional :: sizes(2), lbounds(2)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_double_complex),pointer,intent(inout) :: resultptr(:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(2), opt_lbounds(2)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device3_c8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_double_complex),target,intent(in) :: hostptr(1:1,1:1,*)
    integer,intent(in),optional :: sizes(3), lbounds(3)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_double_complex),pointer,intent(inout) :: resultptr(:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(3), opt_lbounds(3)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device4_c8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_double_complex),target,intent(in) :: hostptr(1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(4), lbounds(4)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_double_complex),pointer,intent(inout) :: resultptr(:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(4), opt_lbounds(4)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device5_c8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_double_complex),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(5), lbounds(5)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_double_complex),pointer,intent(inout) :: resultptr(:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(5), opt_lbounds(5)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device6_c8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_double_complex),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(6), lbounds(6)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_double_complex),pointer,intent(inout) :: resultptr(:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(6), opt_lbounds(6)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):)&
        => resultptr
  end subroutine

  subroutine gpufortrt_use_device7_c8(resultptr,hostptr,sizes,lbounds,if_arg,if_present_arg)
    use iso_c_binding
    implicit none
    complex(c_double_complex),target,intent(in) :: hostptr(1:1,1:1,1:1,1:1,1:1,1:1,*)
    integer,intent(in),optional :: sizes(7), lbounds(7)
    logical,intent(in),optional :: if_arg, if_present_arg
    !
    complex(c_double_complex),pointer,intent(inout) :: resultptr(:,:,:,:,:,:,:)
    !
    type(c_ptr) :: tmp_cptr
    integer :: opt_sizes(7), opt_lbounds(7)
    !
    opt_sizes = 1
    opt_lbounds = 1  
    if ( present(sizes) ) opt_sizes = sizes
    if ( present(lbounds) ) opt_lbounds = lbounds
    tmp_cptr = gpufortrt_use_device_b(c_loc(hostptr),if_arg,if_present_arg)
    call c_f_pointer(tmp_cptr,resultptr,shape=opt_sizes)
    resultptr(&
      opt_lbounds(1):,&
      opt_lbounds(2):,&
      opt_lbounds(3):,&
      opt_lbounds(4):,&
      opt_lbounds(5):,&
      opt_lbounds(6):,&
      opt_lbounds(7):)&
        => resultptr
  end subroutine

  logical function gpufortrt_is_present(data_arg, bytes) 
    use iso_c_binding
    implicit none
    !
    type(*), target, dimension(..)::data_arg
    integer(c_int),value,intent(in) :: bytes
    !
    interface
      type(c_ptr) function gpufortrt_is_present_c_impl(data_arg, bytes) &
        bind(c,name="gpufortrt_present") 
          use iso_c_binding
          implicit none
          !
          type(c_ptr), value::data_arg
          integer(c_size_t), value :: bytes
      end function
    end interface
    gpufortrt_is_present = c_associated(gpufortrt_is_present_c_impl(c_loc(data_arg),int(bytes,kind=c_size_t)))
  end function

  function gpufortrt_map_present(hostptr,num_bytes,never_deallocate) result(retval)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*),dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes 
    logical,intent(in),optional :: never_deallocate
    !
    type(gpufortrt_mapping_t) :: retval
    !
    logical :: opt_never_deallocate = .false._c_bool
    integer(c_size_t) :: opt_num_bytes 
    !
    if( present( never_deallocate )) opt_never_deallocate = never_deallocate
    if( present( num_bytes )) then
      opt_num_bytes = num_bytes
    else 
      opt_num_bytes = int(sizeof(hostptr),kind=c_size_t)
    endif
   
    call gpufortrt_mapping_init(retval,c_loc(hostptr),opt_num_bytes,&
           gpufortrt_map_kind_present,opt_never_deallocate)
  end function

  function gpufortrt_map_no_create(hostptr,num_bytes,never_deallocate) result(retval)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes 
    logical,intent(in),optional :: never_deallocate
    !
    type(gpufortrt_mapping_t) :: retval
    !
    logical :: opt_never_deallocate = .false._c_bool
    integer(c_size_t) :: opt_num_bytes 
    !
    if( present( never_deallocate )) opt_never_deallocate = never_deallocate
    if( present( num_bytes )) then
      opt_num_bytes = num_bytes
    else 
      opt_num_bytes = int(sizeof(hostptr),kind=c_size_t)
    endif

    call gpufortrt_mapping_init(retval,c_loc(hostptr),opt_num_bytes,&
           gpufortrt_map_kind_no_create,opt_never_deallocate)
  end function

  function gpufortrt_map_create(hostptr,num_bytes,never_deallocate) result(retval)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes 
    logical,intent(in),optional :: never_deallocate
    !
    type(gpufortrt_mapping_t) :: retval
    !
    logical :: opt_never_deallocate = .false._c_bool
    integer(c_size_t) :: opt_num_bytes 
    !
    if( present( never_deallocate )) opt_never_deallocate = never_deallocate
    if( present( num_bytes )) then
      opt_num_bytes = num_bytes
    else 
      opt_num_bytes = int(sizeof(hostptr),kind=c_size_t)
    endif
    call gpufortrt_mapping_init(retval,c_loc(hostptr),opt_num_bytes,&
           gpufortrt_map_kind_create,opt_never_deallocate)
  end function

  function gpufortrt_map_copyin(hostptr,num_bytes,never_deallocate) result(retval)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes 
    logical,intent(in),optional :: never_deallocate
    !
    type(gpufortrt_mapping_t) :: retval
    !
    logical :: opt_never_deallocate = .false._c_bool
    integer(c_size_t) :: opt_num_bytes
    !
    if( present( never_deallocate )) opt_never_deallocate = never_deallocate
    if( present( num_bytes )) then
      opt_num_bytes = num_bytes
    else 
      opt_num_bytes = int(sizeof(hostptr),kind=c_size_t)
    endif

    call gpufortrt_mapping_init(retval,c_loc(hostptr),opt_num_bytes,&
           gpufortrt_map_kind_copyin,opt_never_deallocate)
  end function

  function gpufortrt_map_copy(hostptr,num_bytes,never_deallocate) result(retval)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes 
    logical,intent(in),optional :: never_deallocate
    !
    type(gpufortrt_mapping_t) :: retval
    !
    logical :: opt_never_deallocate = .false._c_bool
    integer(c_size_t) :: opt_num_bytes
    !
    if( present( never_deallocate )) opt_never_deallocate = never_deallocate
    if( present( num_bytes )) then
      opt_num_bytes = num_bytes
    else 
      opt_num_bytes = int(sizeof(hostptr),kind=c_size_t)
    endif

    call gpufortrt_mapping_init(retval,c_loc(hostptr),opt_num_bytes,&
           gpufortrt_map_kind_copy,opt_never_deallocate)
  end function

  function gpufortrt_map_copyout(hostptr,num_bytes,never_deallocate) result(retval)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*),dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes 
    logical,intent(in),optional :: never_deallocate
    !
    type(gpufortrt_mapping_t) :: retval
    !
    logical :: opt_never_deallocate = .false._c_bool
    integer(c_size_t) :: opt_num_bytes
    !
    if( present( never_deallocate )) opt_never_deallocate = never_deallocate
    if( present( num_bytes )) then
      opt_num_bytes = num_bytes
    else 
      opt_num_bytes = int(sizeof(hostptr),kind=c_size_t)
    endif

    call gpufortrt_mapping_init(retval,c_loc(hostptr),opt_num_bytes,&
           gpufortrt_map_kind_copyout,opt_never_deallocate)
  end function

  function gpufortrt_map_delete(hostptr,num_bytes,never_deallocate) result(retval)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes 
    logical,intent(in),optional :: never_deallocate
    !
    type(gpufortrt_mapping_t) :: retval
    !
    logical :: opt_never_deallocate = .false._c_bool
    integer(c_size_t) :: opt_num_bytes
    !
    if( present( never_deallocate )) opt_never_deallocate = never_deallocate
    if( present( num_bytes )) then
      opt_num_bytes = num_bytes
    else 
      opt_num_bytes = int(sizeof(hostptr),kind=c_size_t)
    endif

    call gpufortrt_mapping_init(retval,c_loc(hostptr),opt_num_bytes,&
           gpufortrt_map_kind_delete,opt_never_deallocate)
  end function

  function gpufortrt_create(hostptr,num_bytes,never_deallocate,async_arg) result(deviceptr)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in), optional :: num_bytes
    logical, intent(in), optional :: never_deallocate
    integer(gpufortrt_handle_kind),intent(in),optional :: async_arg 
    !
    type(c_ptr) :: deviceptr
    !
    interface
      function gpufortrt_create_c_impl(hostptr,num_bytes,never_deallocate) &
        bind(c,name="gpufortrt_create") result(deviceptr)
        use iso_c_binding
        use gpufortrt_types
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        logical(c_bool),value,intent(in) :: never_deallocate
        !
        type(c_ptr) :: deviceptr
      end function
      function gpufortrt_create_async_c_impl(hostptr,num_bytes,never_deallocate,async_arg) &
        bind(c,name="gpufortrt_create_async") result(deviceptr)
        use iso_c_binding
        use gpufortrt_types
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        logical(c_bool),value,intent(in) :: never_deallocate
        integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
        !
        type(c_ptr) :: deviceptr
      end function
    end interface
    !
    integer(c_size_t) :: opt_num_bytes
    logical(c_bool) :: opt_never_deallocate
    !
    opt_never_deallocate = .false._c_bool
    opt_num_bytes = int(sizeof(hostptr), kind=c_size_t)
    if ( present(never_deallocate) ) opt_never_deallocate = never_deallocate
    if ( present(num_bytes) ) opt_num_bytes = num_bytes
    if ( present(async_arg) ) then
      deviceptr = gpufortrt_create_async_c_impl(c_loc(hostptr),opt_num_bytes,opt_never_deallocate,async_arg)
    else
      deviceptr = gpufortrt_create_c_impl(c_loc(hostptr),opt_num_bytes,opt_never_deallocate)
    endif
  end function

  function gpufortrt_copyin(hostptr,num_bytes,never_deallocate,async_arg) result(deviceptr)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes
    logical,intent(in),optional :: never_deallocate
    integer(gpufortrt_handle_kind),intent(in),optional :: async_arg 
    !
    type(c_ptr) :: deviceptr
    !
    interface
      function gpufortrt_copyin_c_impl(hostptr,num_bytes,never_deallocate) &
          bind(c,name="gpufortrt_copyin") result(deviceptr)
        use iso_c_binding
        use gpufortrt_types
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        logical(c_bool),value,intent(in) :: never_deallocate
        !
        type(c_ptr) :: deviceptr
      end function
      function gpufortrt_copyin_async_c_impl(hostptr,num_bytes,never_deallocate,async_arg) &
        bind(c,name="gpufortrt_copyin_async") result(deviceptr)
        use iso_c_binding
        use gpufortrt_types
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        logical(c_bool),value,intent(in) :: never_deallocate
        integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
        !
        type(c_ptr) :: deviceptr
      end function
    end interface
    !
    logical(c_bool) :: opt_never_deallocate
    integer(c_size_t) :: opt_num_bytes
    !
    opt_never_deallocate = .false._c_bool
    opt_num_bytes = int(sizeof(hostptr), kind=c_size_t)
    if ( present(never_deallocate) ) opt_never_deallocate = never_deallocate
    if ( present(num_bytes) ) opt_num_bytes = num_bytes
    if ( present(async_arg) ) then
      deviceptr = gpufortrt_copyin_async_c_impl(c_loc(hostptr),opt_num_bytes,opt_never_deallocate,async_arg)
    else
      deviceptr = gpufortrt_copyin_c_impl(c_loc(hostptr),opt_num_bytes,opt_never_deallocate)
    endif
  end function

  subroutine gpufortrt_delete(hostptr,num_bytes,async_arg,finalize)
    use iso_c_binding
    use gpufortrt_types, only: gpufortrt_handle_kind
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes
    integer(gpufortrt_handle_kind),intent(in),optional :: async_arg
    logical,intent(in),optional :: finalize
    !
    interface
      subroutine gpufortrt_delete_c_impl(hostptr,num_bytes) &
          bind(c,name="gpufortrt_delete")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
      end subroutine
      subroutine gpufortrt_delete_finalize_c_impl(hostptr,num_bytes) &
          bind(c,name="gpufortrt_delete_finalize")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
      end subroutine
      subroutine gpufortrt_delete_async_c_impl(hostptr,num_bytes,async_arg) &
          bind(c,name="gpufortrt_delete_async")
        use iso_c_binding
        use gpufortrt_types, only: gpufortrt_handle_kind
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
      end subroutine
      subroutine gpufortrt_delete_finalize_async_c_impl(hostptr,num_bytes,async_arg) &
          bind(c,name="gpufortrt_delete_finalize_async")
        use iso_c_binding
        use gpufortrt_types, only: gpufortrt_handle_kind
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
      end subroutine
    end interface
    !
    integer(c_size_t) :: opt_num_bytes
    !
    opt_num_bytes = int(sizeof(hostptr), kind=c_size_t)
    if ( present(num_bytes) ) opt_num_bytes = num_bytes
    if ( present(async_arg) ) then
      if ( present(finalize) ) then
        call gpufortrt_delete_finalize_async_c_impl(c_loc(hostptr),opt_num_bytes,async_arg)
      else
        call gpufortrt_delete_async_c_impl(c_loc(hostptr),opt_num_bytes,async_arg)
      endif
    else
      if ( present(finalize) ) then
        call gpufortrt_delete_finalize_c_impl(c_loc(hostptr),opt_num_bytes)
      else
        call gpufortrt_delete_c_impl(c_loc(hostptr),opt_num_bytes)
      endif
    endif
  end subroutine

  subroutine gpufortrt_copyout(hostptr,num_bytes,async_arg,finalize)
    use iso_c_binding
    use gpufortrt_types, only: gpufortrt_handle_kind
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes
    integer(gpufortrt_handle_kind),intent(in),optional :: async_arg
    logical,intent(in),optional :: finalize
    !
    interface
      subroutine gpufortrt_copyout_c_impl(hostptr,num_bytes) &
          bind(c,name="gpufortrt_copyout")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
      end subroutine
      subroutine gpufortrt_copyout_finalize_c_impl(hostptr,num_bytes) &
          bind(c,name="gpufortrt_copyout_finalize")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
      end subroutine
      subroutine gpufortrt_copyout_async_c_impl(hostptr,num_bytes,async_arg) &
          bind(c,name="gpufortrt_copyout_async")
        use iso_c_binding
        use gpufortrt_types, only: gpufortrt_handle_kind
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
      end subroutine
      subroutine gpufortrt_copyout_finalize_async_c_impl(hostptr,num_bytes,async_arg) &
          bind(c,name="gpufortrt_copyout_finalize_async")
        use iso_c_binding
        use gpufortrt_types, only: gpufortrt_handle_kind
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
      end subroutine
    end interface
    !
    integer(c_size_t) :: opt_num_bytes
    !
    opt_num_bytes = int(sizeof(hostptr), kind=c_size_t)
    if ( present(num_bytes) ) opt_num_bytes = num_bytes
    if ( present(async_arg) ) then
      if ( present(finalize) ) then
        call gpufortrt_copyout_finalize_async_c_impl(c_loc(hostptr),opt_num_bytes,async_arg)
      else
        call gpufortrt_copyout_async_c_impl(c_loc(hostptr),opt_num_bytes,async_arg)
      endif
    else
      if ( present(finalize) ) then
        call gpufortrt_copyout_finalize_c_impl(c_loc(hostptr),opt_num_bytes)
      else
        call gpufortrt_copyout_c_impl(c_loc(hostptr),opt_num_bytes)
      endif
    endif
  end subroutine

  subroutine gpufortrt_update_self(hostptr,num_bytes,if_arg,if_present_arg,async_arg)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*), dimension(..), target, intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes
    logical,intent(in),optional :: if_arg, if_present_arg
    integer(gpufortrt_handle_kind),intent(in),optional :: async_arg
    !
    interface
      subroutine gpufortrt_update_self_c_impl(hostptr,num_bytes,if_arg,if_present_arg) &
              bind(c,name="gpufortrt_update_self")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        logical(c_bool),value,intent(in) :: if_arg, if_present_arg
      end subroutine
      subroutine gpufortrt_update_self_async_c_impl(hostptr,num_bytes,if_arg,if_present_arg,async_arg) &
              bind(c,name="gpufortrt_update_self_async")
        use iso_c_binding
        use gpufortrt_types
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        logical(c_bool),value,intent(in) :: if_arg, if_present_arg
        integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
      end subroutine
    end interface
    logical :: opt_if_arg, opt_if_present_arg
    integer(c_size_t) :: opt_num_bytes
    !
    opt_if_arg = .true.
    opt_if_present_arg = .false.
    opt_num_bytes = int(sizeof(hostptr), kind=c_size_t)
    if ( present(if_arg) ) opt_if_arg = if_arg
    if ( present(if_present_arg) ) opt_if_present_arg = if_present_arg
    if ( present(num_bytes) ) opt_num_bytes = num_bytes
    !
    if ( present(async_arg) ) then
      call gpufortrt_update_self_async_c_impl(c_loc(hostptr),&
                                                         opt_num_bytes,&
                                                         logical(opt_if_arg,c_bool),&
                                                         logical(opt_if_present_arg,c_bool),&
                                                         async_arg)
    else
      call gpufortrt_update_self_c_impl(c_loc(hostptr),&
                                                   opt_num_bytes,&
                                                   logical(opt_if_arg,c_bool),&
                                                   logical(opt_if_present_arg,c_bool))
    endif
  end subroutine

  subroutine gpufortrt_update_device(hostptr,num_bytes,if_arg,if_present_arg,async_arg)
    use iso_c_binding
    use gpufortrt_types
    implicit none
    type(*),dimension(..),target,intent(in) :: hostptr
    integer(c_size_t),intent(in),optional :: num_bytes
    logical,intent(in),optional :: if_arg, if_present_arg
    integer(gpufortrt_handle_kind),intent(in),optional :: async_arg
    !
    interface
      subroutine gpufortrt_update_device_c_impl(hostptr,num_bytes,if_arg,if_present_arg) &
              bind(c,name="gpufortrt_update_device")
        use iso_c_binding
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        logical(c_bool),value,intent(in) :: if_arg, if_present_arg
      end subroutine
      subroutine gpufortrt_update_device_async_c_impl(hostptr,num_bytes,if_arg,if_present_arg,async_arg) &
              bind(c,name="gpufortrt_update_device_async")
        use iso_c_binding
        use gpufortrt_types
        implicit none
        type(c_ptr),value,intent(in) :: hostptr
        integer(c_size_t),value,intent(in) :: num_bytes
        logical(c_bool),value,intent(in) :: if_arg, if_present_arg
        integer(gpufortrt_handle_kind),value,intent(in) :: async_arg
      end subroutine
    end interface
    logical :: opt_if_arg, opt_if_present_arg
    integer(c_size_t) :: opt_num_bytes
    !
    opt_if_arg = .true.
    opt_if_present_arg = .false.
    opt_num_bytes = int(sizeof(hostptr), kind=c_size_t)
    if ( present(if_arg) ) opt_if_arg = if_arg
    if ( present(if_present_arg) ) opt_if_present_arg = if_present_arg
    if ( present(num_bytes) ) opt_num_bytes = num_bytes
    !
    if ( present(async_arg) ) then
      call gpufortrt_update_device_async_c_impl(c_loc(hostptr),&
                                                         opt_num_bytes,&
                                                         logical(opt_if_arg,c_bool),&
                                                         logical(opt_if_present_arg,c_bool),&
                                                         async_arg)
    else
      call gpufortrt_update_device_c_impl(c_loc(hostptr),&
                                                   opt_num_bytes,&
                                                   logical(opt_if_arg,c_bool),&
                                                   logical(opt_if_present_arg,c_bool))
    endif
  end subroutine
end module