#!/bin/bash
if [ -f /var/lib/sbctl-enroll-script ]; then
        exit 0
fi
function enroll_sign {
        sbctl enroll-keys -m -i &&
        sbctl verify | sed -E 's|^.* (/.+) is not signed$|sbctl sign -s "\1"|e'
        touch /var/lib/sbctl-enroll-script
}
enroll_sign
