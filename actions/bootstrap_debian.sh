#!/usr/bin/env sh
set -e

export DEBIAN_FRONTEND=noninteractive
PACKAGES="unzip wget ruby ruby-dev git unzip wget gnupg2"
RUBY_PACKAGES="ruby ruby-dev"
AUGEAS_PACKAGES="libaugeas-dev pkg-config"

if [ "$CODENAME" = "wheezy" ] || [ "$CODENAME" = "jessie" ]; then
    PACKAGES="bundler apt-transport-https $PACKAGES"
elif [ "$CODENAME" = "precise" ]; then
    BUILD_RUBY=true
    GEM_BUNDLER=true
    unset RUBY_PACKAGES
else
    # Note: Those packages are needed to build ruby-augeas gem
    AUGEAS_PACKAGES="pkg-config libaugeas-dev augeas-tools"
    PACKAGES="ruby-bundler $PACKAGES $AUGEAS_PACKAGES"
fi

apt-get update
apt-get -y install $PACKAGES $RUBY_PACKAGES $AUGEAS_PACKAGES

if [ -n "$BUILD_RUBY" ]; then
    install_rvm
fi

if [ -n "$GEM_BUNDLER" ]; then
    gem install --no-ri --no-rdoc bundler
fi
