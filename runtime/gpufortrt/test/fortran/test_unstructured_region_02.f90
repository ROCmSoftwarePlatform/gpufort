program main
  use iso_c_binding
  logical(c_bool) :: x(10)
  !$acc init
  !$acc enter data copyin(x) async
  call foo(x)
  !$acc exit data delete(x) async
  !$acc wait
  !$acc shutdown
contains
  subroutine foo(x)
    logical(c_bool) :: x(:)
    !$acc enter data create(x) async
    !$acc exit data copyout(x) async
  end subroutine
end program