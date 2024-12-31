CURR_DIR := $(shell pwd)
DIR_NAME := $(notdir $(shell pwd))
TIMESTAMP := $(shell date +%Y%m%d)

PROJ_NAME := poky-kirkstone-4.0.23
MODULE_NAMES += bzip2
MODULE_NAMES += glib-2.0

# Where is source code?
PATH_x86_ROOT := /home/yantao/workshop/makefile/yocto/$(PROJ_NAME)
PATH_x86_BUILD := $(PATH_x86_ROOT)/build/tmp/work/core2-64-poky-linux

PATH_x86 :=
$(foreach module_name,$(MODULE_NAMES),\
	$(eval SUBIDR := $(shell ls -d $(PATH_x86_BUILD)/$(module_name)/*)) \
	$(eval PATH_x86 += $(SUBIDR)) \
)

PATH_BB :=
$(foreach module_name,$(MODULE_NAMES),\
	$(eval SUBDIR := $(shell find $(PATH_BB_ROOT) -name "$(module_name)_*.bb"))\
	$(eval SRCDIR := $(shell grep SRC_URI $(SUBDIR) | tr -d ' ')) \
	$(eval PATH_BB += $(SRCDIR) $(SUBDIR)) \
)

# Where is build result?
DESTDIR := $(CURR_DIR)/build

# make
.PHONY: all
all:
	@echo ""
	@echo "cd $(PATH_x86_ROOT) && source oe-init-build-env"
	@echo "cd $(PWD)"
	@echo ""
	@for dir in $(MODULE_NAMES); do \
		echo "bitbake $$dir"; \
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
	rm $(DESTDIR)* -rf

# make tarball
.PHONY: tarball
tarball:
	mkdir -p $(DESTDIR)
	@for path in $(PATH_x86); do \
		cp -r $$path/image/* $(DESTDIR); \
	done
	cd $(DESTDIR) && tar czf build-$(DIR_NAME)_$(TIMESTAMP).tar.gz *
	mv $(DESTDIR)/build-$(DIR_NAME)*.tar.gz .
