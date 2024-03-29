#!/usr/bin/env sh
set -e

export PKG_PATH="ftp://ftp.openbsd.org/pub/OpenBSD/$REV/packages/$ARCH/"

# install wget
pkg_add wget git

if [ $REV = 5.7 ]; then
    pkg_add ruby-2.0.0.598p1
    pkg_add ruby20-bundler-1.3.5p1
elif [ $REV = 5.6 ]; then
    pkg_add ruby-2.0.0.481
    pkg_add ruby20-bundler-1.3.5p0
elif [ $REV = 5.5 ]; then
    pkg_add ruby-2.0.0.353
    pkg_add ruby20-bundler-1.3.5p0
else
    echo "Oops. Not sure which rubies to get. Please help!"
    exit 1
fi
