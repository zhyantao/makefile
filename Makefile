CURR_DIR := $(shell pwd)

sub_dir := buildroot gptp tests

all:
	@for dir in $(sub_dir); do \
		if [ -d $$dir ]; then \
			make patch -C $$dir $@ || exit 1; \
			make -C $$dir $@ || exit 1; \
		fi \
	done

clean:
	@for dir in $(sub_dir); do \
		if [ -d $$dir ]; then \
			make -C $$dir clean || exit 1; \
		fi \
	done
