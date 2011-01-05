# Copyright 2008-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2 or later
# $Id$

PN = emacs-updater
PV = $(shell sed '/^VERSION/!d;s/[^0-9.]*\([^ \t]*\).*/\1/;q' emacs-updater)
P = $(PN)-$(PV)

DISTFILES = emacs-updater emacs-updater.8 ChangeLog


.PHONY: all dist clean

all:

dist: $(DISTFILES)
	tar -cjf $(P).tar.bz2 --transform='s%^%$(P)/%' $^
	tar -tjvf $(P).tar.bz2

clean:
	-rm -f *~ *.tmp *.gz *.bz2
