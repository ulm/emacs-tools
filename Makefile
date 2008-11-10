# Copyright 2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

PN = emacs-daemon
PV = $(shell sed '/^[ \t]*\* .*[Vv]ersion/!d;s/[^0-9.]*\([0-9.]*\).*/\1/;q' \
	ChangeLog)
P = $(PN)-$(PV)

DISTFILES = ChangeLog emacs.rc emacs.conf 10emacs-daemon-gentoo.el


.PHONY: all dist clean

all:

dist: $(DISTFILES)
	tar -cjf $(P).tar.bz2 --transform='s%^%$(P)/%' $^
	tar -tjvf $(P).tar.bz2

clean:
	-rm -f *~ *.tmp *.gz *.bz2
