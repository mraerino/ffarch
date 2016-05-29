#!/bin/sh
rsync -ur /vagrant/src/* /build/

cd /build

./build.sh -v && ./cleanup.sh
