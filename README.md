## mimas

Command line project for developing HDL code for Numato Lab's Mimas development
board.

## FAQ

### What is mimas?

mimas is a command line project that allows development and flashing of HDL
code. No GUI is necessary to develop hardware code using this project. This
project also contains support for flashing using Numato Lab's Mimas
Configuration tool (numato-loader will have support soon).

### What license is mimas release under?

This project is in the public domain.

### How do you use mimas?

First you need to build the project, install ISE before proceeding. If you're
having issues there is some configuration in Makefile for directories:

	$ git clone https://github.com/amilkovich/mimas.git
	$ cd mimas
	$ make flash
