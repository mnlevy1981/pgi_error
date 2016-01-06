program pgi_err

  implicit none
  
  type :: child_type
    integer, dimension(3,3) :: matrix
  end type

  type :: parent_type
    type(child_type), dimension(4) :: second
  end type

  type :: indexing_type
    integer :: first
    integer :: second
    integer :: third
    integer :: fourth
  end type

  type(parent_type) :: first
  type(indexing_type) :: lots_of_indices

  integer :: i
  integer, dimension(3) :: array

  lots_of_indices%first=1
  lots_of_indices%second=2
  lots_of_indices%third=3
  lots_of_indices%fourth=4

  array(:) = 3
  do i=1,4
    first%second(i)%matrix(:,:) = 5
  end do

  associate(&
            kids => first%second(:), &
            ind => lots_of_indices   &
           )
    ! NOTE: using lots_of_indices instead of ind below
    !       compiles fine with PGI
    kids(ind%first)%matrix(:,1) = array(:)
  end associate

  print*, first%second(1)%matrix(2,:)

end program pgi_err
