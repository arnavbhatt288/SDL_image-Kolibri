CC = kos32-gcc
LD = kos32-ld
OBJCOPY = kos32-objcopy

SDK_DIR = ../../..
LDFLAGS = -nostdlib -static --image-base 0 -T $(SDK_DIR)/sources/newlib/app.lds --subsystem native
CFLAGS = -c -fno-ident -O2 -fomit-frame-pointer -U__WIN32__ -U_Win32 -U_WIN32 -U__MINGW32__ -UWIN32 -D_KOLIBRI
CFLAGS += -DLOAD_JPG -DLOAD_PNG -DLOAD_BMP -DLOAD_GIF -DLOAD_LBM -DLOAD_PCX -DLOAD_PNM \
		-DLOAD_TGA -DLOAD_XCF -DLOAD_XPM -DLOAD_XV -DLOAD_SVG -DLOAD_QOI
CFLAGS += -DSDL_IMAGE_SAVE_JPG=1 -DSDL_IMAGE_SAVE_PNG=1
LIBS = -lSDL2image -lSDL2test -lSDL2 -ljpeg -lpng16 -lz.dll -lgcc -lc.dll -lc -lsound

INCLUDES = -I $(SDK_DIR)/sources/newlib/libc/include -I../include/ -I../../SDL-2.30.3/include/
LIBPATH = -L $(SDK_DIR)/lib -L /home/autobuild/tools/win32/mingw32/lib

default: testimage

testimage: $(OBJECTS) Makefile
	$(CC) $(CFLAGS) $(INCLUDES) -o main.o main.c
	$(LD) $(LDFLAGS) $(LIBPATH) --subsystem native -o main main.o $(LIBS)
	kos32-strip -s main -o main
	kos32-objcopy main -O binary
	rm main.o

clean:
	rm main
