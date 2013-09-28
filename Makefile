wiimote-pad: wiimote-pad.c
	$(CC) -Wall -o $@ $< -I../xwiimote/lib -ludev -lxwiimote

clean:
	@rm -rf wiimote-pad
