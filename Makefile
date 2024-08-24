CC = kos32-gcc
AR = kos32-ar
LD = kos32-ld
STRIP = kos32-strip

LIBNAME=libSDL2_image

LIBS:= -lSDL2 -ljpeg -lpng16 -lz.dll -lgcc -lc.dll -ldll -lsound

LDFLAGS+= -shared -s -T dll.lds --entry _DllStartup --image-base=0 --out-implib $(LIBNAME).dll.a
LDFLAGS+= -L/home/autobuild/tools/win32/mingw32/lib -L../../lib

OBJS =	src/IMG.o \
		src/IMG_bmp.o \
		src/IMG_gif.o \
		src/IMG_jpg.o \
		src/IMG_lbm.o \
		src/IMG_pcx.o \
		src/IMG_png.o \
		src/IMG_pnm.o \
		src/IMG_svg.o \
		src/IMG_tga.o \
		src/IMG_tif.o \
		src/IMG_xcf.o \
		src/IMG_xpm.o \
		src/IMG_xv.o \
    	src/IMG_webp.o \
     	src/IMG_qoi.o \
      	src/IMG_avif.o \
       	src/IMG_jxl.o \
        src/IMG_stb.o


CFLAGS = -c -O2 -mpreferred-stack-boundary=2 -fno-ident -fomit-frame-pointer -fno-stack-check \
-fno-stack-protector -mno-stack-arg-probe -fno-exceptions -fno-asynchronous-unwind-tables \
-ffast-math -mno-ms-bitfields -march=pentium-mmx \
-U_Win32 -UWIN32 -U_WIN32 -U__MINGW32__ -U__WIN32__ \
-I../newlib/libc/include/ -I../SDL-2.30.3/include/ -I../libjpeg/ -I.. -I../libpng/ -Iinclude/ -Isrc/ \
-DLOAD_JPG -DLOAD_PNG -DLOAD_BMP -DLOAD_GIF -DLOAD_LBM -DLOAD_PCX -DLOAD_PNM \
-DLOAD_TGA -DLOAD_XCF -DLOAD_XPM -DLOAD_XV -DLOAD_SVG -DLOAD_QOI \
-DSDL_IMAGE_SAVE_JPG=1 -DSDL_IMAGE_SAVE_PNG=1

all:  $(LIBNAME).a $(LIBNAME).dll

$(LIBNAME).a: $(OBJS)
	$(AR) -crs  ../../lib/$@ $^

$(LIBNAME).dll: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
	$(STRIP) -S $@

%.o : %.c Makefile
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f $(OBJS) ../../lib/$(LIBNAME).a $(LIBNAME).dll $(LIBNAME).dll.a
