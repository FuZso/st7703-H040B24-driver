# Makefile for ST7703 H040B24 panel driver

KERNEL_VERSION ?= $(shell uname -r)
KERNEL_DIR ?= /lib/modules/$(KERNEL_VERSION)/build
PWD := $(shell pwd)

obj-m := panel-sitronix-st7703-H040B24.o

all:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) clean

install: all
	sudo $(MAKE) -C $(KERNEL_DIR) M=$(PWD) modules_install
	#sudo depmod -a $(KERNEL_VERSION)

load:
	sudo modprobe panel-sitronix-st7703

unload:
	sudo modprobe -r panel-sitronix-st7703

dto-panel:
	sudo dtc -@ -I dts -O dtb -o st7703-H040B24.dtbo st7703-H040B24-overlay.dts
	sudo cp st7703-H040B24.dtbo /boot/firmware/overlays/

dto-all: dto-panel

.PHONY: all clean install load unload dto-panel dto-touch dto-all