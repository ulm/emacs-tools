# Copyright 2007-2014 Gentoo Foundation
# Distributed under the terms of the GNU GPL version 2 or later

PN = eselect-emacs
PV = $(shell sed '/^[ \t]*VERSION=/!d;s/.*="\?\([^ \t"]*\).*/\1/;q' \
	emacs.eselect)
P = $(PN)-$(PV)

MODULES = emacs.eselect ctags.eselect etags.eselect
MANPAGES = emacs.eselect.5 ctags.eselect.5 etags.eselect.5

DISTFILES = emacs.eselect ctags.eselect emacs.eselect.5 ctags.eselect.5 \
	ChangeLog Makefile

.PHONY: all dist clean

all: $(MODULES) $(MANPAGES)

etags.eselect: ctags.eselect
	sed -e "/^CTAGS=/s/ctags/etags/" $< >$@

etags.eselect.5: ctags.eselect.5
	cp $< $@

dist: $(DISTFILES)
	tar -cJf $(P).tar.xz --transform='s%^%$(P)/%' $^
	tar -tJvf $(P).tar.xz

clean:
	-rm -f *~ *.tmp *.gz *.bz2 *.xz
