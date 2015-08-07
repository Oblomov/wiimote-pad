XWIIMOTE ?=../xwiimote

CFLAGS ?=
CFLAGS += -std=c99
CFLAGS += -D_BSD_SOURCE
CFLAGS += -Wall -Wextra

CPPFLAGS ?=
CPPFLAGS += -I$(XWIIMOTE)/lib

LDFLAGS ?=
LDFLAGS += -L$(XWIIMOTE)/.libs
LDFLAGS += -ludev
LDFLAGS += -lxwiimote

wiimote-pad: wiimote-pad.c

clean:
	@rm -rf wiimote-pad
