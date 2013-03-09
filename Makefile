# Copyright 2008-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2 or later

PN = emacs-updater
PV = $(shell sed '/^VERSION/!d;s/[^0-9.]*\([^ \t]*\).*/\1/;q' emacs-updater)
P = $(PN)-$(PV)

DISTFILES = emacs-updater emacs-updater.8 ChangeLog


.PHONY: all dist clean

all:

dist: $(DISTFILES)
	tar -cJf $(P).tar.xz --transform='s%^%$(P)/%' $^
	tar -tJvf $(P).tar.xz

clean:
	-rm -f *~ *.tmp *.gz *.bz2 *.xz
