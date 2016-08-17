#!/bin/env bash
# Check for prerequisites: dbus-1 and sigc++
pkg=`ldconfig -p | grep dbus-1 | wc -l`;
if [[ $pkg -eq 0 ]]; then
    echo "DBUS library missing!";
    exit 1
fi

pkg=`ldconfig -p | grep sigc | wc -l`;
if [[ $pkg -eq 0 ]]; then
    echo "SIGC library missing!";
    exit 1
fi

./autogen.sh
./configure
make
make install
# Update libraries
ldconfig