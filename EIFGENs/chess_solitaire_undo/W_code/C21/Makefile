INCLUDE_PATH =  -I"$(ISE_LIBRARY)/library/encoding/implementation/include" -I"$(ISE_LIBRARY)/library/time/spec/include" -I"$(ISE_LIBRARY)/library/vision2/spec/include" -I"$(ISE_LIBRARY)/library/vision2/implementation/gtk/Clib"  -D_REENTRANT -I/opt/local/include/gtk-2.0 -I/opt/local/lib/gtk-2.0/include -I/opt/local/include/pango-1.0 -I/opt/local/include/gio-unix-2.0/ -I/opt/local/include -I/opt/local/include/cairo -I/opt/local/include/atk-1.0 -I/opt/local/include/cairo -I/opt/local/include/pixman-1 -I/opt/local/include -I/opt/local/include/gdk-pixbuf-2.0 -I/opt/local/include/libpng16 -I/opt/local/include/pango-1.0 -I/opt/local/include/harfbuzz -I/opt/local/include -I/opt/local/include/pango-1.0 -I/opt/local/include/fribidi -I/opt/local/include -I/opt/local/include/ossp -I/opt/local/include/freetype2 -I/opt/local/include/libpng16 -I/opt/local/include -I/opt/local/include/glib-2.0 -I/opt/local/lib/glib-2.0/include -I/opt/local/include
SHELL = /bin/sh
CC = cc
CPP = c++
CFLAGS = -O0 -pipe -fno-common -fPIC -DEIF_THREADS -DEIF_POSIX_THREADS  -DWORKBENCH -I"/Applications/MacPorts/Eiffel_19.05/studio/spec/macosx-x86-64/include" -I. $(INCLUDE_PATH)
CPPFLAGS = -O0 -pipe -fno-common -fPIC -DEIF_THREADS -DEIF_POSIX_THREADS  -DWORKBENCH -I"/Applications/MacPorts/Eiffel_19.05/studio/spec/macosx-x86-64/include" -I. $(INCLUDE_PATH)
LDFLAGS = 
CCLDFLAGS =   
LDSHAREDFLAGS =   -dynamiclib -flat_namespace -undefined suppress -o
EIFLIB = "/Applications/MacPorts/Eiffel_19.05/studio/spec/macosx-x86-64/lib/libmtwkbench.a"
EIFTEMPLATES = /Applications/MacPorts/Eiffel_19.05/studio/config/macosx-x86-64/templates
LIBS = -lm -lpthread
MAKE = make
AR = ar
LD = ld
MKDEP = \$(EIFFEL_SRC)/C/mkdep $(DPFLAGS) --
MV = /bin/mv
CP = /bin/cp
RANLIB = :
RM = /bin/rm -f
FILE_EXIST = 
RMDIR = 
X2C = "/Applications/MacPorts/Eiffel_19.05/studio/spec/macosx-x86-64/bin/x2c"
SHAREDLINK = cc
SHAREDLIBS = -lm
SHARED_SUFFIX = .dylib
COMMAND_MAKEFILE = 
START_TEST = if [ ! -f finished ] ; then 
END_TEST = ; fi 
CREATE_TEST = touch finished 
SYSTEM_IN_DYNAMIC_LIB = chess_solitaire_undo.dylib 

.SUFFIXES:.cpp .o

.c.o:
	$(CC) $(CFLAGS) -c $<

.cpp.o:
	$(CPP) $(CPPFLAGS) -c $<

OBJECTS = big_file_C21_c.o 

OLDOBJECTS =  fu1623.o fu1623d.o in1628.o in1628d.o pr1620.o pr1620d.o ac1622.o \
	ac1622d.o ac1627.o ac1627d.o li1619.o li1619d.o kl1624.o kl1624d.o \
	ev1621.o ev1621d.o ev1626.o ev1626d.o kl1625.o kl1625d.o kl1629.o \
	kl1629d.o 

all: Cobj21.o

Cobj21.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj21.o $(OBJECTS)
	$(RM) $(OBJECTS)
	$(CREATE_TEST)

clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core finished *.o

local_clobber:: local_clean
	$(RM) Makefile

