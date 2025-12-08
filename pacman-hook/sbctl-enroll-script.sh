#!/bin/bash

hook_file="/etc/pacman.d/hooks/99-sbctl.hook"
script_file="/usr/local/bin/sbctl-enroll-script.sh"

if [ -f /tmp/sbctl-after-run ]; then
        exit 0
fi

function enroll_sign {
        sbctl enroll-keys -m -i &&
        sbctl verify | sed -E 's|^.* (/.+) is not signed$|sbctl sign -s "\1"|e'
        touch /tmp/sbctl-after-run
}
enroll_sign

if [ -f "$hook_file" ]; then
        rm "$hook_file"
fi
if [ -f "$script_file" ]; then
        rm "$hook_file"
fi

echo "clean up complete"
