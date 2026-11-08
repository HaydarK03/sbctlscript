#!/bin/bash

function enroll_sign {
        sbctl enroll-keys -m -i &&
        sbctl verify | sed -E 's|^.* (/.+) is not signed$|sbctl sign -s "\1"|e'
}
enroll_sign


echo "clean up complete"
