#!/bin/sh

self="$(realpath "$0")"
wdir="$(dirname "$self")"
pushd "$wdir"
xcodegen && xcodebuild -configuration Release || exit $?
rm MacQutebrowser.zip
cd "$wdir/build/Release" || exit $?
zip -r "$wdir/MacQutebrowser.zip" MacQutebrowser.app || exit $?
popd
