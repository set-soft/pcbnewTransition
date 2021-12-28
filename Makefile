#!/usr/bin/make

.PHONY: clean package release

all: doc package

package:
	rm -f dist/*
	python3 setup.py sdist bdist_wheel

install: package
	pip3 install --no-deps --force dist/*.whl

release: package
	twine upload dist/*

clean:
	rm -rf dist build

deb:
	DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -uc -b

deb_clean:
	fakeroot debian/rules clean

.PHONY: deb deb_clean
