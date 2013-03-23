# Copyright 2008-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2 or later

PN = emacs-daemon
PV = $(shell sed '/^[ \t]*\* .*[Vv]ersion/!d;s/[^0-9.]*\([0-9.]*\).*/\1/;q' \
	ChangeLog)
P = $(PN)-$(PV)

DISTFILES = README ChangeLog emacs.rc emacs.conf emacs-wrapper.sh \
	emacs-stop.sh 10emacs-daemon-gentoo.el


.PHONY: all dist clean

all:

dist: $(DISTFILES)
	tar -cJf $(P).tar.xz --transform='s%^%$(P)/%' $^
	tar -tJvf $(P).tar.xz

clean:
	-rm -f *~ *.tmp *.xz
