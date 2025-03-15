#!/bin/bash
# Start Emacs with a login shell wrapper to read the user's profile
exec -l "${SHELL:-/bin/bash}" -c "exec \"${EMACS}\" $*"
