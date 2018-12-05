#!/bin/bash
# Bad script for self-use
# Do some sweet FA with this.

export GOARCH=arm64
export GOOS=darwin
export GOROOT=$(dirname $(pwd))
export GOROOT_FINAL=/usr/local/libexec/go
export PATH=$GOROOT/bin:$PATH
export CGO_ENABLED=1
export CC_FOR_TARGET="aarch64-apple-darwin17-clang"
export CXX_FOR_TARGET="aarch64-apple-darwin17-clang++"
export URL="https://dl.google.com/go/go1.11.2.src.tar.gz"


case "$1" in
	download)
		wget $URL; tar xvf go1.11.2.src.tar.gz; rm go1.11.2.src.tar.gz*; exit 0
	;;
	make)
		echo "Making..."; cd go/src/; GOROOT_FINAL=$GOROOT_FINAL ./make.bash --no-clean; exit 0
	;;
	clean)
		echo "Cleaning..."; cd go/src/; `which bash` ./clean.bash; exit 0
	;;
	purge)
		echo "Purging..."; rm -rf go; exit 0
	;;
	package)
		echo "Packing"
		destdir=testinstall/usr/local/libexec/go
		mkdir -p ${PWD}/${destdir}; cp -r go/* ${destdir}/; echo "TODO: auto clean up unneeded"
		exit 0
	;;
	patch)
		patchdir=patches
		for i in $(ls ${patchdir}/); do
		patch -p1 < ${patchdir}/$i
		done
	;;
	*)
		echo "Bad argument - \""$@"\"."
		exit 1
	;;
esac
