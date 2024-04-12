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

REPO_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# Write to shared library location, where other packages can use these
# libraries during build.
SHARED_LIB=${GEOIPS_DEPENDENCIES_DIR}/share/lib/fortran_utils/
SHARED_INC=${GEOIPS_DEPENDENCIES_DIR}/share/inc/fortran_utils/

all:
	make -C src/config
	make -C src/orderpack
	make -C src/utils
	make -C src/utils $(REPO_DIR)/fortran_utils/lib/datetime_utils.o
	make -C src/utils $(REPO_DIR)/fortran_utils/lib/file_io_utils.o
	make -C src/utils $(REPO_DIR)/fortran_utils/lib/prettyprint.o
	make -C src/utils $(REPO_DIR)/fortran_utils/lib/string_operations.o
	# Copy to shared lib and inc for other packages build
	mkdir -p $(SHARED_LIB)
	mkdir -p $(SHARED_INC)
	cp $(REPO_DIR)/fortran_utils/lib/* $(SHARED_LIB)
	cp $(REPO_DIR)/fortran_utils/inc/* $(SHARED_INC)

clean:
	make -C src/config clean
	make -C src/orderpack clean
	make -C src/utils clean
	rm -fv ${GEOIPS_DEPENDENCIES_DIR}/share/lib/fortran_utils/*
	rm -fv ${GEOIPS_DEPENDENCIES_DIR}/share/inc/fortran_utils/*
