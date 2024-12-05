CURR_DIR := $(shell pwd)

# where is source code?
PROJECT_NAME := poky
VERSION := kirkstone-4.0.23
TAR_BALL := $(PROJECT_NAME)-$(VERSION).tar.gz
SRC_DIR := $(CURR_DIR)/$(PROJECT_NAME)-$(VERSION)

# where is the build results?
DESTDIR := $(CURR_DIR)/build

BB_NO_NETWORK=1

# make
.PHONY: all
all:
	@cd $(SRC_DIR) && source oe-init-build-env
	@cd $(SRC_DIR) && bitbake meta-toolchain -c populate_sdk
	# @install -D -t $(DESTDIR) $(SRC_DIR)/output/images/*

# make clean
.PHONY: clean
clean:
	rm -rf $(SRC_DIR)
	rm -rf $(DESTDIR)

# make patch
.PHONY: patch
patch:
	tar zxf $(TAR_BALL)
	mkdir -p $(SRC_DIR)/build/downloads
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
	@echo "Requirements: \033[35m sudo apt install -y gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file locales libacl1 \033[0m"
	@echo "You can download all packages from \033[35m https://pan.quark.cn/s/d8b9ea5a37e6\033[0m, then unzip them to\033[31m $(SRC_DIR)/build/downloads\033[0m"
	@echo ""
	@echo "Step 1:\033[35m make patch \033[0m  Apply patches"
	@echo "Step 2:\033[35m make repo  \033[0m  Initilize git repository and commit"
	@echo "Step 3:\033[35m make       \033[0m  Check if the modifications are valid"
	@echo "Step 4:\033[35m TODO: edit \033[0m  Create, edit and save modifications"
	@echo "Step 5:\033[35m make diff  \033[0m  Generate a patch file"
	@echo ""
