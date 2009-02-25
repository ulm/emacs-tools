#!/bin/bash
# Copyright 2008-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# Start Emacs with a login shell wrapper to read the user's profile
exec -l "${SHELL}" -c "exec \"${EMACS}\" $*" </dev/null &>/dev/null &
pid=$!

# Wait for Emacs daemon to detach
for (( t=${EMACS_TIMEOUT:-30}; t > 0; t-- )); do
    sleep 1
    if ! kill -0 ${pid} 2>/dev/null; then
        wait ${pid}		# get exit status
        exit
    fi
done

echo "${0##*/}: timeout waiting for ${EMACS} to detach" >&2
kill ${pid} $(pgrep -P ${pid}) 2>/dev/null
exit 1
