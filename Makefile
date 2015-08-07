XWIIMOTE ?=../xwiimote

wiimote-pad: wiimote-pad.c
	$(CC) -Wall -o $@ $< -I$(XWIIMOTE)/lib -L$(XWIIMOTE)/.libs -ludev -lxwiimote

clean:
	@rm -rf wiimote-pad
