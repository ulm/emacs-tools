# This Makefile creates the tarball to be uploaded to the Gentoo mirrors
#
# Copyright 2007-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

PN = eselect-emacs
#PV = $(shell sed '/^Version/h;$$!d;g;s/[^0-9.]*\([0-9.]*\).*/\1/' ChangeLog)
PV = $(shell sed '/^[ \t]*\* .*[Vv]ersion/!d;s/[^0-9.]*\([^ \t]*\).*/\1/;q' \
	ChangeLog)
P = $(PN)-$(PV)

DISTFILES = emacs.eselect ctags.eselect \
	emacs.eselect.5 ctags.eselect.5 ChangeLog


.PHONY: all dist clean

all:

dist: $(DISTFILES)
	tar -cjf $(P).tar.bz2 --transform='s%^%$(P)/%' $^
	tar -tjvf $(P).tar.bz2

clean:
	-rm -f *~ *.tmp *.gz *.bz2
