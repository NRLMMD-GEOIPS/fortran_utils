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
REPO_DIR:=$(shell dirname $(realpath $(REPO_DIR)))
REPO_DIR:=$(shell dirname $(realpath $(REPO_DIR)))

G2SRC=$(REPO_DIR)/src
LIB=$(REPO_DIR)/fortran_utils/lib
INC=$(REPO_DIR)/fortran_utils/inc

FINCS = -I. -I$(INC)
FLIBS = -L. -L$(LIB)

ifeq ('$(GEOIPS_FORTRAN_COMPILER)','ifort')
FC = ifort
FFLAGS = -warn all -fPIC -O3 -module $(INC) $(FLIBS) $(FINCS)
else
FC = gfortran
FFLAGS = -Wall -fPIC -O3 -J$(INC) $(FLIBS) $(FINCS)
endif

$(LIB)/config.o: $(G2SRC)/config/config.f90.template.sh
	echo "${GEOIPS_FORTRAN_COMPILER} $(FC)"
	$(G2SRC)/config/config.f90.template.sh > $(G2SRC)/config/config.f90
	mkdir -p $(INC) $(LIB)
	touch $(LIB)/__init__.py
	$(FC) -c $(FFLAGS) $(G2SRC)/config/config.f90 -o $@

clean:
	rm -fv $(REPO_DIR)/fortran_utils/lib/*
	rm -fv $(REPO_DIR)/fortran_utils/inc/*
