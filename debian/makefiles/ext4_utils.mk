# Makefile for ext4_utils; based on https://heiher.info/2227.html
# Author: Dmitrijs Ledkovs <xnox@ubuntu.com>

SRCDIR ?= $(CURDIR)

VPATH+= $(SRCDIR)/extras/ext4_utils
SRCS+=make_ext4fs.c
SRCS+=ext4fixup.c
SRCS+=ext4_sb.c
SRCS+=ext4_utils.c
SRCS+=allocate.c
SRCS+=contents.c
SRCS+=extent.c
SRCS+=indirect.c
SRCS+=uuid.c
SRCS+=sha1.c
SRCS+=wipe.c
SRCS+=crc16.c
SRCS+=canned_fs_config.c

VPATH+= $(SRCDIR)/core/libsparse
SRCS+= backed_block.c
SRCS+= sparse_crc32.c
SRCS+= sparse.c
SRCS+= sparse_read.c
SRCS+= sparse_err.c
SRCS+= output_file.c

OBJS_SHARED:= $(SRCS:.c=.o)

SRCS+=make_ext4fs_main.c
SRCS+=ext4fixup_main.c
SRCS+=setup_fs.c
SRCS+=ext2simg.c
SRCS+=img2simg.c
SRCS+=simg2img.c
SRCS+=simg2simg.c

CPPFLAGS+= -I$(SRCDIR)/extras/ext4_utils
CPPFLAGS+= -I/usr/include
CPPFLAGS+= -I$(SRCDIR)/core/include
CPPFLAGS+= -I$(SRCDIR)/core/libsparse/include
CPPFLAGS+= -include /usr/include/android/arch/linux-x86/AndroidConfig.h

LIBS+= -lz -lselinux

OBJS= $(SRCS:.c=.o)

all: make_ext4fs ext4fixup ext2simg img2simg simg2img simg2simg

make_ext4fs ext4fixup: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $(OBJS_SHARED) $@_main.o $(LIBS)

ext2simg img2simg simg2img simg2simg: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $(OBJS_SHARED) $@.o $(LIBS)

clean:
	rm -rf $(OBJS) ext2simg ext4fixup make_ext4fs img2simg simg2img simg2simg

