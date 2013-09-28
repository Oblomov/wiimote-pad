XWIIMOTE=../xwiimote/lib

wiimote-pad: wiimote-pad.c
	$(CC) -Wall -o $@ $< -I$(XWIIMOTE) -ludev -lxwiimote

clean:
	@rm -rf wiimote-pad
