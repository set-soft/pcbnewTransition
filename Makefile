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
	@-[ ! -f versioneer.py.ok ] && mv versioneer.py versioneer.py.ok
	@-[ ! -f pcbnewTransition/_version.py.ok ] && mv pcbnewTransition/_version.py pcbnewTransition/_version.py.ok
	cp debian/versioneer.py .
	DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -uc -b
	mv versioneer.py.ok versioneer.py
	mv pcbnewTransition/_version.py.ok pcbnewTransition/_version.py

deb_clean:
	fakeroot debian/rules clean

.PHONY: deb deb_clean
