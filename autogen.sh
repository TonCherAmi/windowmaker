#!/bin/sh

# Generate the documentation about compiling Window Maker
./script/generate-txt-from-texi.sh "doc/build/Compilation.texi"  -o "INSTALL-WMAKER"
./script/generate-txt-from-texi.sh "doc/build/Translations.texi" -o "README.i18n"

# Change date of the files to the past so they will be regenerated by 'make'
touch -d '2000-01-01' INSTALL-WMAKER README.i18n

# Generate the configure script from the 'configure.ac'
autoreconf -vfi -I m4

exit 0

if [ -x config.status -a -z "$*" ]; then
  ./config.status --recheck
else
  if test -z "$*"; then
    echo "I am going to run ./configure with no arguments - if you wish "
    echo "to pass any to it, please specify them on the $0 command line."
    echo "If you do not wish to run ./configure, press Ctrl-C now."
    trap 'echo "configure aborted" ; exit 0' 1 2 15
    sleep 1
  fi
  ./configure "$@"
fi
