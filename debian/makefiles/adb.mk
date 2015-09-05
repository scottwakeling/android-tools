# Makefile for adb; from https://heiher.info/2227.html

SRCDIR ?= $(CURDIR)

VPATH+= $(SRCDIR)/core/adb
SRCS+= adb.c
SRCS+= adb_client.c
SRCS+= adb_auth_host.c
SRCS+= commandline.c
SRCS+= console.c
SRCS+= file_sync_client.c
SRCS+= fdevent.c
SRCS+= get_my_path_linux.c
SRCS+= services.c
SRCS+= sockets.c
SRCS+= transport.c
SRCS+= transport_local.c
SRCS+= transport_usb.c
SRCS+= usb_linux.c
SRCS+= usb_vendors.c

VPATH+= $(SRCDIR)/core/libcutils
SRCS+= socket_inaddr_any_server.c
SRCS+= socket_local_client.c
SRCS+= socket_local_server.c
SRCS+= socket_loopback_client.c
SRCS+= socket_loopback_server.c
SRCS+= socket_network_client.c
SRCS+= load_file.c

VPATH+= $(SRCDIR)/core/libzipfile
SRCS+= centraldir.c
SRCS+= zipfile.c


CPPFLAGS+= -D_XOPEN_SOURCE -D_GNU_SOURCE
CPPFLAGS+= -DADB_HOST=1
CPPFLAGS+= -I$(SRCDIR)/core/adb
CPPFLAGS+= -I$(SRCDIR)/core/include
CPPFLAGS+= -include /usr/include/android/arch/linux-x86/AndroidConfig.h

LIBS+= -lc -lpthread -lz -lcrypto

OBJS= $(SRCS:.c=.o)

all: adb

adb: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $(OBJS) $(LIBS)

clean:
	rm -rf $(OBJS) adb
