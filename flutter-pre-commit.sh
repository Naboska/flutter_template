#!/bin/sh
set -e

flutter clean
flutter packages upgrade
flutter analyze
flutter dart format --set-exit-if-changed lib test
flutter pub run import_sorter:main lib\/*
