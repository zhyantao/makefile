CURR_DIR := $(shell pwd)
DIR_NAME := $(notdir $(shell pwd))
TIMESTAMP := $(shell date +%Y%m%d_%H%M%S)

include sdk.mk

# where is source code?
PROJECT_NAME := linuxptp
VERSION := 4.2
TAR_BALL := $(PROJECT_NAME)-$(VERSION).tgz
SRC_DIR := $(CURR_DIR)/$(PROJECT_NAME)-$(VERSION)

EXTRA_CFLAGS += -DHAVE_ONESTEP_P2P

# where is the build results?
DESTDIR := $(CURR_DIR)/build

# make
.PHONY: all
all:
	@cd $(SRC_DIR) && make -C $(SRC_DIR) all
	@cd $(SRC_DIR) && make -C $(SRC_DIR) install

# make clean
.PHONY: clean
clean:
	rm -rf $(SRC_DIR)
	rm -rf $(DESTDIR)

# make patch
.PHONY: patch
patch:
	tar zxf $(TAR_BALL)
	@if [ ! -d "patches" ]; then mkdir -p $(CURR_DIR)/patches; fi
	# @cd $(SRC_DIR) && patch -p1 < $(CURR_DIR)/patches/0000-undefined.patch
	@rm -rf $(DESTDIR) && mkdir -p $(DESTDIR)

# make repo
.PHONY: repo
repo:
	@cd $(SRC_DIR) && if [ ! -d ".git" ]; then git init; fi
	@cd $(SRC_DIR) && git config --add core.filemode false
	@cd $(SRC_DIR) && git config --global core.autocrlf false
	@cd $(SRC_DIR) && git add .
	@cd $(SRC_DIR) && git commit -m "commit before make patch"
	@echo "$(SRC_DIR) is already up to date"

# make diff
.PHONY: diff
diff:
	@cd $(SRC_DIR) && git config --add core.filemode false
	@cd $(SRC_DIR) && git config --global core.autocrlf false
	@cd $(SRC_DIR) && git add .
	@cd $(SRC_DIR) && git diff --cached > $(CURR_DIR)/patches/0000-undefined.patch
	@echo "patch file is saved to $(CURR_DIR)/patches/0000-undefined.patch"

# make help
.PHONY: help
help:
	@echo ""
	@echo "Step 1:\033[35m make patch \033[0m  Apply patches"
	@echo "Step 2:\033[35m make repo  \033[0m  Initilize git repository and commit"
	@echo "Step 3:\033[35m make       \033[0m  Check if the modifications are valid"
	@echo "Step 4:\033[35m TODO: edit \033[0m  Create, edit and save modifications"
	@echo "Step 5:\033[35m make diff  \033[0m  Generate a patch file"
	@echo ""

# make tarball
.PHONY: tarball
tarball:
	cp -r $(DESTDIR)/usr/local/* $(DESTDIR)/usr
	rm -rf $(DESTDIR)/usr/local
	cd $(DESTDIR) && tar czf build-$(DIR_NAME)_$(TIMESTAMP).tar.gz usr
	mv $(DESTDIR)/build-*.tar.gz .
