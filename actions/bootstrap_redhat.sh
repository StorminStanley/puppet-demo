#!/usr/bin/env sh
set -e

PACKAGES=""

if [ $MAJORVER = "6" ]; then
    EPEL="https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm"
    TOOL_PACKAGES="nscd nc git unzip curl scl-utils"
    RUBY_PACKAGES="ruby193 ruby193-ruby-devel"
    PYTHON_PACKAGES="python27 python27-pip python27-virtualenv python27-devel"
    AUGEAS_PACKAGES="augeas augeas-devel"
    PACKAGES="$TOOL_PACKAGES $RUBY_PACKAGES $PYTHON_PACKAGES $AUGEAS_PACKAGES"
    SCL="centos-release-SCL"
elif [ $MAJORVER = "7" ]; then
    EPEL="https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"
    PACKAGES="ruby ruby-devel rubygem-bundler unzip curl git-core augeas augeas-devel"
fi

# Install EPEL on RHEL boxen
if [ -n "$EPEL" ]; then
    if [ ! -f /etc/yum.repos.d/epel.repo ]; then
        rpm -ivh $EPEL
    fi
fi

# If we're using the Software Collection Library, downlad the repo
# and get it ready for usage. Needs to happen before other packages
# attempt to install
if [ -n "$SCL" ]; then
    yum install -y $SCL
fi

yum clean all
yum clean dbcache
yum groupinstall -y "Development Tools"

yum install -y $PACKAGES
