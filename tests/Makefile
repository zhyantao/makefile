CURR_DIR := $(shell pwd)
DESTDIR := $(CURR_DIR)/build

SITE_PACKAGES_DIR = $(shell python -c "import site; print(site.getsitepackages()[0]);")

TARGETS := socket_server socket_client

CFLAGS += -Wall -O2 -D_GNU_SOURCE
CFLAGS += -ggdb
CFLAGS += -fPIC
ifdef SYSROOT
CFLAGS += --sysroot $(SYSROOT)
endif

LDLIBS += -lpthread

.PHONY : all depend dep

all : .depend $(TARGETS)

.depend depend dep :
	$(CC) $(CFLAGS) -M $(TARGETS:=.cc) > .depend

ifeq (.depend,$(wildcard .depend))
include .depend
endif

install : all
	install -D -m 755 -t $(DESTDIR)/usr/bin $(TARGETS)

uninstall :
	for f in $(TARGETS); do rm $(DESTDIR)/usr/bin/$$f; done

.PHONY : clean
clean :
	rm -f *.o *~ core .depend
	rm -f ${TARGETS}
	rm -rf $(DESTDIR)

.PHONY: patch
patch:
	@rm -rf $(DESTDIR) && mkdir -p $(DESTDIR)

.PHONY : format
format:
	find . -type f \( -name "*.cpp" -o -name "*.c" -o -name "*.cc" -o -name "*.h" -o -name "*.hpp" \) \
	-not -path "./.git/*" \
	-not -path "./.svn/*" \
	-not -path "./.github/*" \
	-exec $(SITE_PACKAGES_DIR)/clang_format/data/bin/clang-format -i {} +
