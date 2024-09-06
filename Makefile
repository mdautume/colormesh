CFLAGS ?= -O3 
CXXFLAGS ?= -O3 -std=c++14
LDLIBS += -lm -lfftw3f -lgdal -lz -ltiff -lpng -ljpeg -lstdc++ \
	  -fsanitize=address -lGeographicLib

OBJ = src/drawtriangle.o src/geographiclib_wrapper.o src/iio.o src/normals.o \
      src/pickopt.o src/rpc.o src/trimesh.o
BIN = create_mesh triproc get_utm_normal_shadow write_coloured_ply \
      colorize_vertices_from_one_image

BIN := $(addprefix bin/,$(BIN))

default: $(BIN) 

bin/%  : src/%.o $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)


# CONFIGURABLE DEPENDENCIES
# XXX: comment (or not) the following lines to disable (enable) image formats
# Note: just comment the lines, do NOT change the ones to zeros!

ENABLE_PNG  = 1
ENABLE_TIFF = 1
ENABLE_JPEG = 1
#ENABLE_WEBP = 1
#ENABLE_HEIF = 1
#ENABLE_PGSL = 1

# CAVEAT: if you want to use HDF5, make sure that no "mpich" packages
# are installed on your computer.  If they are, all programs that link
# to libdf5 become really slow due to dynamic linking initialization.
#
#ENABLE_HDF5 = 1





#
# END OF CORE PART, THE REST OF THIS FILE IS NOT ESSENTIAL
#
