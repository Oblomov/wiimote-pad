# Wiimote-Pad

This is a small tool to use a Wiimote as a gamepad.

## Introduction

Linux has had built-in support for the Wii Remote (Wiimote for short)
since v3.1, support which was significantly cleaned up and improved
since v3.11. However, the low-level kernel driver exposes each component
of the Wiimote (accelerator, buttons, IR camera), as well as each
extension, as a distinct device, none of which is (fully) functional as
a controller ‘out of the box’ (the ‘buttons’ device —which the driver
calls the controller ‘proper’— does appear as a joystick device to
Linux, since it has a BTN\_A mapping, but it's a device with no axes and
thus not really usable).

A higher level interface (built on top of the Linux driver) is provided
by [xwiimote][], which provides a library for ‘coalesced’ access to the
Wiimote and its extension. As programs need to be designed specifically
to make use of the library, this still doesn't allow an ‘out of the box’
experience.

The purpose of this tool is to allow any application to use a Wiimote
—held sideways— as if it were a standard gamepad, with a 2-axes joystick
(using the accelerometer), and a D-Pad.

## Usage

Associate your Wiimote with your computer (details on how to do this are
not discussed here, but you may want to look at [xwiimote][]'s page for
additional information), then start the program. As long as the program
is running, a virtual controller (called “Nintendo Remote in gamepad
mode”) will be available. Just press Ctrl+C to terminate the program and
‘disconnect’ the virtual controller.

Syntax:

	wiimote-pad [device]

where _device_ is the path to a Linux-created device associated with the
Wiimote (e.g. `/dev/input/js0` or something like that). If no _device_
is specified, the program will look for the first device that it can
associate with and use that.

## D-pad orientation

Since 2017, by default, the D-pad will be oriented in landscape mode (the
arm closest to the A button will be mapped to _right_ rather than
_down_), in accordance to the Wiimote orientation.

This is a break from the previous behavior of the program. If you prefer
the old behavior, you can pass the command-line option `--dpad
portrait`, which will set the D-pad in portrait mode (arm closest to the
A button will be mapped to _down_). You can enforce the new behavior
with `--dpad landscape`, and even specify different D-pad settings for
different Wiimotes, for example:

	wiimote-pad --dpad portrait /dev/input/js0 --dpad landscape /dev/input/js1

will set the `js0` Wiimote with the D-pad in portrait mode, and the
`js1` one with the D-pad in landscape mode.

### Note

`wiimote-pad` is _specifically_ designed to expose the sideways Wiimote
as a gamepad. All other Wiimote uses (especially the ones involving
the infrared (IR) sensor) are outside of its scope. Please refer to the
`xwiimote` and `xf86-input-wiimote` projects for those.

## `udev` rules

This repository also provides a set of `udev` rules to:

* change the group and the permissions of all Wiimote-related devices
  (both the kernel ones and the virtual one created by `wiimote-pad`);
* create descriptive symlinks for the event devices associated with
  Wiimotes.

By default the group assigned to Wiimote devices is `bluetooth`, you
might need to tune it for your system. The group and permission change
is needed so that applications that use the event interface instead of
the joystick interface can still access the Wiimote.

## Requirements

Dependencies for `wiimote-pad` are `libudev` and `libxwiimote`. The
latter should be version 2 or higher.

## Compile

Just running

	make

should work.

If you compiled and built `libxwiimote` yourself, you might
need to fix the include path in the `Makefile` to point to the correct
locations to look for the headers, or run

	make XWIIMOTE=/path/to/xwiimote/sources

instead. By default, aside from standard locations, the `Makefile` will
look for an `xwiimote` source directory in the parent of the
`wiimote-pad` directory.

[xwiimote]: http://dvdhrm.github.io/xwiimote
