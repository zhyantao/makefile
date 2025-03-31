CURR_DIR := $(shell pwd)
BUILDTMP_DIR := $(CURR_DIR)/buildtmp
DESTDIR := $(CURR_DIR)/build

# Get python site-packages directory
SITE_PACKAGES_DIR = $(shell python -c "import site; print(site.getsitepackages()[0]);")

# Define targets
TARGETS := socket_server socket_client

CFLAGS += -Wall -O2 -D_GNU_SOURCE
CFLAGS += -ggdb
CFLAGS += -fPIC
ifdef SYSROOT
CFLAGS += --sysroot $(SYSROOT)
endif

LDLIBS += -lpthread

# Object files path
OBJS := $(addprefix $(BUILDTMP_DIR)/, $(TARGETS:=.o))

.PHONY : all depend dep

# Default target
all : .depend $(TARGETS) install

# Create buildtmp directory
$(BUILDTMP_DIR):
	mkdir -p $(BUILDTMP_DIR)

# Generate dependency file
.depend depend dep : $(BUILDTMP_DIR)
	$(CC) $(CFLAGS) -M $(TARGETS:=.cc) > $(BUILDTMP_DIR)/.depend

# Include dependency file if exists
ifeq ($(wildcard $(BUILDTMP_DIR)/.depend),$(BUILDTMP_DIR)/.depend)
include $(BUILDTMP_DIR)/.depend
endif

# Compile source files into object files in buildtmp directory
$(BUILDTMP_DIR)/%.o: %.cc $(BUILDTMP_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Link object files to create executables
$(TARGETS): %: $(BUILDTMP_DIR)/%.o
	$(CC) $< -o $(BUILDTMP_DIR)/$@ $(LDLIBS)

# Install executables to build directory
install : all
	install -D -m 755 -t $(DESTDIR)/usr/bin $(addprefix $(BUILDTMP_DIR)/, $(TARGETS))

uninstall :
	for f in $(TARGETS); do rm -f $(DESTDIR)/usr/bin/$$f; done

.PHONY : clean
clean :
	rm -rf $(DESTDIR) $(BUILDTMP_DIR)

# Format code
.PHONY : format
format:
	find . -type f \( -name "*.cpp" -o -name "*.c" -o -name "*.cc" -o -name "*.h" -o -name "*.hpp" \) \
	-not -path "./.git/*" \
	-not -path "./.svn/*" \
	-not -path "./.github/*" \
	-exec $(SITE_PACKAGES_DIR)/clang_format/data/bin/clang-format -i {} +
