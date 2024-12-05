CURR_DIR := $(shell pwd)

BUILDROOT_DIR := $(HOME)/toolchain/buildroot/arm-buildroot-linux-gnueabihf_sdk-buildroot
SYSROOT := $(BUILDROOT_DIR)/arm-buildroot-linux-gnueabihf/sysroot
TOOLCHAIN_DIR := $(BUILDROOT_DIR)/bin
PATH := $(TOOLCHAIN_DIR):$(PATH)

# cross compile options
ARCH := arm
CROSS_COMPILE := arm-buildroot-linux-gnueabihf-

CC := $(CROSS_COMPILE)gcc
# CXX := $(CROSS_COMPILE)g++
AS := $(CROSS_COMPILE)as
LD := $(CROSS_COMPILE)ld
STRIP := $(CROSS_COMPILE)strip
RANLIB := $(CROSS_COMPILE)ranlib
OBJCOPY := $(CROSS_COMPILE)objcopy
OBJDUMP := $(CROSS_COMPILE)objdump
AR := $(CROSS_COMPILE)ar
NM := $(CROSS_COMPILE)nm

CFLAGS := --sysroot=$(SYSROOT) -I$(SYSROOT)/usr/include -g -Wall
# CXXFLAGS := --sysroot=$(SYSROOT) -I$(SYSROOT)/usr/include -g -Wall
LDFLAGS := -L$(SYSROOT)/lib -L$(SYSROOT)/usr/lib

PKG_CONFIG_DIR := "$(SYSROOT)/usr/lib/pkgconfig"
PKG_CONFIG_PATH := "$(PKG_CONFIG_DIR):$(SYSROOT)/usr/share/pkgconfig"
PKG_CONFIG_LIBDIR := "$(PKG_CONFIG_DIR)"
PKG_CONFIG_SYSROOT := "$(SYSROOT)"
PKG_CONFIG_DISABLE_UNINSTALLED := "yes"
