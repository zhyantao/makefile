CURR_DIR := $(shell pwd)
DIR_NAME := $(notdir $(shell pwd))
TIMESTAMP := $(shell date +%Y%m%d)

PROJ_NAME := poky-kirkstone-4.0.23
MODULE_NAMES += bzip2
MODULE_NAMES += glib-2.0

# Where is source code?
PATH_win_ROOT := \\\\127.0.0.1\\username\\workshop\\makefile\\yocto\\$(PROJ_NAME)
PATH_x86_ROOT := /home/username/workshop/makefile/yocto/$(PROJ_NAME)
PATH_win_BUILD := $(PATH_win_ROOT)\\build\\tmp\\work\\aarch64-linux
PATH_x86_BUILD := $(PATH_x86_ROOT)/build/tmp/work/aarch64-linux

PATH_win :=
PATH_x86 :=
$(foreach module_name,$(MODULE_NAMES),$(eval PATH_win += $(PATH_win_BUILD)\\$(module_name)))
$(foreach module_name,$(MODULE_NAMES),\
	$(eval SUBIDR := $(shell ls -d $(PATH_x86_BUILD)/$(module_name)/*)) \
	$(eval PATH_x86 += $(SUBIDR)) \
)

# Where is build result?
DESTDIR := $(CURR_DIR)/build

# make
.PHONY: all
all:
	@echo ""
	@echo "cd $(PATH_x86_ROOT) && source build.sh ZM9300"
	@echo "cd $(PWD)"
	@echo ""
	@for dir in $(MODULE_NAMES); do \
		echo "bitbake $$dir"; \
	done
	@echo ""
	@echo "Build Result on Windows:"
	@for path in $(PATH_win); do \
		echo $$path; \
	done
	@echo ""
	@echo "Build Result on Linux:";
	@for path in $(PATH_x86); do \
		echo $$path; \
	done
	@echo ""

# make clean
.PHONY: clean
clean:
	rm $(DESTDIR) -rf

# make tarball
.PHONY: tarball
tarball:
	mkdir -p $(DESTDIR)
	@for path in $(PATH_x86); do \
		cp -r $$path/image/* $(DESTDIR); \
	done
	cd $(DESTDIR) && tar czf build-$(DIR_NAME)_$(TIMESTAMP).tar.gz *
	mv $(DESTDIR)/build-$(DIR_NAME)*.tar.gz .
