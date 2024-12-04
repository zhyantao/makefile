CURR_DIR := $(shell pwd)

BUILDROOT_DIR := $(HOME)/toolchain/buildroot/arm-buildroot-linux-gnueabihf_sdk-buildroot
SYSROOT_DIR := $(BUILDROOT_DIR)/arm-buildroot-linux-gnueabihf/sysroot
TOOLCHAIN_DIR := $(BUILDROOT_DIR)/bin
export PATH := $(TOOLCHAIN_DIR):$(PATH)

# cross compile options
export ARCH := arm
export CROSS_COMPILE := arm-buildroot-linux-gnueabihf-

export CC := $(CROSS_COMPILE)gcc
# export CXX := $(CROSS_COMPILE)g++
export AS := $(CROSS_COMPILE)as
export LD := $(CROSS_COMPILE)ld
export STRIP := $(CROSS_COMPILE)strip
export RANLIB := $(CROSS_COMPILE)ranlib
export OBJCOPY := $(CROSS_COMPILE)objcopy
export OBJDUMP := $(CROSS_COMPILE)objdump
export AR := $(CROSS_COMPILE)ar
export NM := $(CROSS_COMPILE)nm

export CFLAGS := --sysroot=$(SYSROOT_DIR) -I$(SYSROOT_DIR)/usr/include -g -Wall
# export CXXFLAGS := --sysroot=$(SYSROOT_DIR) -I$(SYSROOT_DIR)/usr/include -g -Wall
export LDFLAGS := -L$(SYSROOT_DIR)/lib -L$(SYSROOT_DIR)/usr/lib

export PKG_CONFIG_DIR := "$(SYSROOT_DIR)/usr/lib/pkgconfig"
export PKG_CONFIG_PATH := "$(PKG_CONFIG_DIR):$(SYSROOT_DIR)/usr/share/pkgconfig"
export PKG_CONFIG_LIBDIR := "$(PKG_CONFIG_DIR)"
export PKG_CONFIG_SYSROOT_DIR := "$(SYSROOT_DIR)"
export PKG_CONFIG_DISABLE_UNINSTALLED := "yes"
