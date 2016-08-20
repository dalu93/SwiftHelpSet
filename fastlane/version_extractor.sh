#! /bin/bash

VERSION_LINE=$(cat ../SwiftHelpSet.podspec | grep -m 1 -o "^.*version.*=.*$")
VERSION=$(echo $VERSION_LINE | grep -o -m 1 "[\"\'][0-9a-zA-Z.]*[0-9a-zA-Z][\"\']")
VERSION=$(echo $VERSION | grep -o -m 1 "[0-9a-zA-Z.]*[0-9a-zA-Z]")
VERSION_RELEASE=$(echo $VERSION | grep -o -m 1 "[0-9a-z.]*[0-9a-z]")

echo $VERSION_RELEASE
