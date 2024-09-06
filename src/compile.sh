FLAGS="-g -Wall -Wextra -Werror -Wno-unused -Wno-unused-parameter -fsanitize=address"

g++ -c refine.cc -o refine.o -g -I /usr/local/Cellar/cgal/5.6.1/include/ -std=c++14

LIBS="-lz -ltiff -lpng -ljpeg -lm -lstdc++ -lgdal -fsanitize=address"

g++ refine.o -L /usr/local/Cellar/cgal/5.6.1/lib/ -o ../bin/refine -lgmp
