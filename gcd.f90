! SYNOPSIS:
!
! # gfortran -o gcd-f gcd.f90
! # ./gcd-f 11 22 33 121
!

program GCD
  implicit none

  integer, allocatable :: ns(:)
  integer :: i, n
  character(len=20) :: tmpstr

  n = command_argument_count()

  allocate (ns(n))

  do i = 1, n
    call get_command_argument(i, tmpstr)
    ns(i) = str2int(tmpstr)
  end do

  print '(I0)', gcdn(ns)

  deallocate (ns)

contains

  pure integer function str2int(s)
    character*(*), intent(in) :: s
    read (s, *) str2int
  end function

  pure recursive integer function gcd2(a, b) result(GCD)
    integer, intent(in) :: a, b
    if (b == 0) then
      GCD = a
    else
      GCD = gcd2(b, mod(a, b))
    end if
  end function gcd2

  pure integer function gcdn(n)
    integer, intent(in) :: n(:)
    integer :: i
    gcdn = n(1)
    do i = 2, size(n)
      gcdn = gcd2(gcdn, n(i))
    end do
  end function

end program
