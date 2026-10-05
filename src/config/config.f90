module config
    implicit none

    character(len=256), parameter :: ancildat_path = &
      '/ancildat'
    character(len=256), parameter :: ancildat_autogen_path = &
      '/ancildat_autogen'

    !integer, parameter :: bd = 8 ! bit depth

    !f2py character(len=256) :: ancildat_path, ancildat_autogen_path

end module config
