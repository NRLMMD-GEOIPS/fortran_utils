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
F2P_COMPILER_FLAGS = --fcompiler=intelem --compiler=intelem
FFLAGS = -warn all -fPIC -O3 -module $(INC) $(FLIBS) $(FINCS)
else
FC = gfortran
F2P_COMPILER_FLAGS = --fcompiler=gnu95
FFLAGS = -Wall -fPIC -O3 -J$(INC) $(FLIBS) $(FINCS)
endif

F2PCFLAGS = $(F2P_COMPILER_FLAGS) --opt="-O3" $(FLIBS) $(FINCS)
# F2PCFLAGS = --fcompiler=$(FCNAME) --quiet --opt="-O3" $(FLIBS) $(FINCS)
# F2PCFLAGS = --fcompiler=$(FCNAME) --f90flags='-fopenmp' -lgomp --quiet --opt="-O3" $(FLIBS) $(FINCS)

#####################################################
### Top level liberror_codes.so build - used to import from python
# ERRORS
$(LIB)/liberror_codes.so: error_codes.f90 $(LIB)/io_messages.o $(LIB)/errors.o $(LIB)/config.o

#####################################################
### $(INC)/*.mod builds, used within fortran programs
$(LIB)/io_messages.o: io_messages.f90 $(LIB)/config.o
$(LIB)/error_codes.o: error_codes.f90 $(LIB)/io_messages.o
$(LIB)/errors.o: errors.f90 $(LIB)/error_codes.o
$(LIB)/datetime_utils.o: datetime_utils.f90 $(LIB)/errors.o
$(LIB)/file_io_utils.o: file_io_utils.f90
$(LIB)/prettyprint.o: prettyprint.f90
$(LIB)/clip.o: clip.f90
$(LIB)/normalize.o: normalize.f90 $(LIB)/clip.o
$(LIB)/string_operations.o: string_operations.f90
$(LIB)/percentile.o: percentile.f90 $(LIB)/mrgrnk.o

#####################################################
### Required builds from other fortran packages
$(LIB)/mrgrnk.o:
	make -C $(G2SRC)/orderpack $(LIB)/mrgrnk.o
$(LIB)/config.o:
	make -C $(G2SRC)/config $(LIB)/config.o


#####################################################
### Actual build commands for *.so (f2py) and *.o (gfortran) files
$(LIB)/lib%.so: %.f90
	mkdir -p $(INC) $(LIB)
	touch $(LIB)/__init__.py
	f2py $(F2PCFLAGS) -m lib$* -c $?
	ls -l lib$**.so
	mv lib$**.so $(LIB)/lib$*.so

$(LIB)/%.o: %.f90
	mkdir -p $(INC) $(LIB)
	touch $(LIB)/__init__.py
	# This also creates $(INC)/$*.mod
	$(FC) -c $(FFLAGS) $< -o $@

clean:
	rm -fv $(REPO_DIR)/fortran_utils/lib/*
	rm -fv $(REPO_DIR)/fortran_utils/inc/*


#####################################################
# I have no idea 
# newunit.o: newunit.f90
# 	$(FC) -c $(FFLAGS) $<


