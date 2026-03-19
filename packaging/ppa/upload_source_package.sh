#!/bin/bash

# Print commands, exit on error
set -xe

# Go to script's directory
cd "$(dirname "$0")"

PKGNAME="qcsuper"
PKGVER="2.1.0.post3"
PKGREL="1"

# Needed to generate a .tar.gz that will contain a setup.py
# file generated from our pyproject.toml located at
# project root

poetry build -f sdist

for version in noble questing resolute; do # bionic focal jammy noble questing

    py2dsc-deb -x stdeb.cfg --suite ${version} --sign-results --sign-key 87EC6DB535CC2A084B41E88EF675C22E1B4B2ACC \
        --debian-version ${PKGREL}${version} ../../dist/${PKGNAME}-${PKGVER}.tar.gz

    dput ppa:marin-m/qcsuper "deb_dist/${PKGNAME}_${PKGVER}-${PKGREL}${version}_source.changes"

done
