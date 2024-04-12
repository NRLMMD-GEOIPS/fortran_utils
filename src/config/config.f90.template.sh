#!/bin/sh

# # # Distribution Statement A. Approved for public release. Distribution unlimited.
# # #
# # # Author:
# # # Naval Research Laboratory, Marine Meteorology Division
# # #
# # # This program is free software: you can redistribute it and/or modify it under
# # # the terms of the NRLMMD License included with this program. This program is
# # # distributed WITHOUT ANY WARRANTY; without even the implied warranty of
# # # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the included license
# # # for more details. If you did not receive the license, for more information see:
# # # https://github.com/U-S-NRL-Marine-Meteorology-Division/

# Script to generate config.f90 file with hard coded paths to the ancildat directories, using
# appropriate locations based on GEOIPS_OUTDIRS environment variable.

fname="config.f90"
if [[ "$GEOIPS_ANCILDAT" != "" ]]; then
    ancildatdir="$GEOIPS_ANCILDAT"
else
    ancildatdir="$GEOIPS_OUTDIRS/ancildat"
fi

if [[ "$GEOIPS_ANCILDAT_AUTOGEN" != "" ]]; then
    ancildat_autogen="$GEOIPS_ANCILDAT_AUTOGEN"
else
    ancildat_autogen="$GEOIPS_OUTDIRS/ancildat_autogen"
fi

echo "module config"
echo "    implicit none"
echo ""
echo "    character(len=256), parameter :: ancildat_path = &"
echo "      '$ancildatdir'"

echo "    character(len=256), parameter :: ancildat_autogen_path = &"
echo "      '$ancildat_autogen'"
echo ""
echo "    !integer, parameter :: bd = 8 ! bit depth"
echo ""
echo "    !f2py character(len=256) :: ancildat_path, ancildat_autogen_path"
echo ""
echo "end module config"
