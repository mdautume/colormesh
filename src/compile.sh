#FLAGS="-g -Wall -Wextra -Werror -Wno-unused -Wno-unused-parameter -fsanitize=address"
FLAGS="-g"

gcc -c iio.c -o iio.o $FLAGS
gcc -c triproc.c -o triproc.o $FLAGS
gcc -c drawtriangle.c -o drawtriangle.o $FLAGS
gcc -c pickopt.c -o pickopt.o $FLAGS
gcc -c trimesh.c -o trimesh.o $FLAGS
gcc -c rpc.c -o rpc.o $FLAGS
gcc -c normals.c -o normals.o $FLAGS $(bash gdal-config --cflags)
gcc -c create_mesh.c -o create_mesh.o $FLAGS $(bash gdal-config --cflags)
gcc -c get_utm_normal_shadow.c -o get_utm_normal_shadow.o $FLAGS $(bash gdal-config --cflags)
gcc -c colorize_vertices_from_one_image.c -o colorize_vertices_from_one_image.o $FLAGS $(bash gdal-config --cflags)
gcc -c write_coloured_ply.c -o write_coloured_ply.o $FLAGS $(bash gdal-config --cflags)
g++ -c geographiclib_wrapper.cpp -o geographiclib_wrapper.o $FLAGS $(bash gdal-config --cflags)
g++ -c refine.cc -o refine.o -g -I /usr/local/Cellar/cgal/5.6.1/include/ -std=c++14

LIBS="-lz -ltiff -lpng -ljpeg -lm -lstdc++ -lgdal -fsanitize=address"
gcc iio.o drawtriangle.o trimesh.o rpc.o pickopt.o normals.o get_utm_normal_shadow.o geographiclib_wrapper.o -o ../bin/get_utm_normal_shadow $LIBS
gcc iio.o trimesh.o rpc.o pickopt.o normals.o colorize_vertices_from_one_image.o geographiclib_wrapper.o -o ../bin/colorize_vertices_from_one_image $LIBS 
gcc iio.o trimesh.o pickopt.o write_coloured_ply.o -o ../bin/write_coloured_ply $LIBS
gcc iio.o trimesh.o rpc.o create_mesh.o -o ../bin/create_mesh $LIBS 
gcc trimesh.o triproc.o -o ../bin/triproc

g++ refine.o -L /usr/local/Cellar/cgal/5.6.1/lib/ -o ../bin/refine -lgmp
