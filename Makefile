SUBDIRS = datasheet

all:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

pdf:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir pdf; \
	done

html:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir html; \
	done

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

.PHONY: all clean pdf html
