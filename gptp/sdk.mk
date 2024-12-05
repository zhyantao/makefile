CURR_DIR := $(shell pwd)

BUILDROOT_DIR := $(HOME)/toolchain/buildroot/arm-buildroot-linux-gnueabihf_sdk-buildroot
SYSROOT_DIR := $(BUILDROOT_DIR)/arm-buildroot-linux-gnueabihf/sysroot
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

CFLAGS := --sysroot=$(SYSROOT_DIR) -I$(SYSROOT_DIR)/usr/include -g -Wall
# CXXFLAGS := --sysroot=$(SYSROOT_DIR) -I$(SYSROOT_DIR)/usr/include -g -Wall
LDFLAGS := -L$(SYSROOT_DIR)/lib -L$(SYSROOT_DIR)/usr/lib

PKG_CONFIG_DIR := "$(SYSROOT_DIR)/usr/lib/pkgconfig"
PKG_CONFIG_PATH := "$(PKG_CONFIG_DIR):$(SYSROOT_DIR)/usr/share/pkgconfig"
PKG_CONFIG_LIBDIR := "$(PKG_CONFIG_DIR)"
PKG_CONFIG_SYSROOT_DIR := "$(SYSROOT_DIR)"
PKG_CONFIG_DISABLE_UNINSTALLED := "yes"
