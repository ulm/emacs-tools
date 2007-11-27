#!/bin/bash

# Licensed under GPL version 2
# Author Christian Faulhammer <opfer@gentoo.org>

SITELISP=/usr/share/emacs/site-lisp
VERSION=0.1
TMPFILE=$(mktemp /tmp/emacs-cleaner.XXXXXX)

echo "Emacs updater version ${VERSION}"
echo "Find packages that are installed in the wrong location, file bugs on http://bugs.gentoo.org/"
echo
echo "Note, you must use the eclasses from the Emacs Overlay for proper operation! "
echo

if ! [ -x /usr/bin/qfile ]; then
    echo "Please emerge app-portage/portage-utils to use this tool"
    exit 1
fi

for sf in "${ROOT}/${SITELISP}"/[0-9][0-9]*-gentoo.el
do
    echo "Processing ${sf}"
    qfile -qC "${sf}" >> "${TMPFILE}"
done

echo
echo "Packages with site files in the wrong location:"
cat "${TMPFILE}"

echo
echo -n "Remerge packages? [Yes/No] "
read choice
echo
case "${choice}" in
     y*|Y*|"")
          ;;
     *)
	message "Quitting."
	echo
	exit 10 ;;
esac

emerge -av $(cat "${TMPFILE}")
