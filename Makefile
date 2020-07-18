# Makefile for pybase

# calculate BASEDIR from the Makefile in case we are invoked with make -C
# make's builtin $(dir) doesn't handle spaces in folders very well...
BASEDIR ?= $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")
SRCDIR ?= $(BASEDIR)/src

APPNAME ?= pybase
APPVER ?= 3.8

PY := PYTHONPATH="$(SRCDIR)" python3

################################################################################
.PHONY: all

all: build

################################################################################
.PHONY: build

build: test
	docker image build --tag "$(APPNAME):dev" "$(BASEDIR)"

################################################################################
.PHONY: rebuild

rebuild: test
	docker image build --pull --no-cache --tag "$(APPNAME):dev" "$(BASEDIR)"

################################################################################
.PHONY: release

# XXX do we need this section (or even a Makefile?) ...  could we just use the
# CI/CD hooks available on Docker Hub instead?

release: build
	docker image tag "$(APPNAME):dev" "$(APPNAME):latest"
	docker image tag "$(APPNAME):latest" "$(APPNAME):$(APPVER)"

################################################################################
.PHONY: test

# TODO use the container for tests (or at least provide an option)...

test:
	$(PY) -m unittest discover -v -s "$(BASEDIR)/test"

################################################################################
.PHONY: run

# launch the container with a few mount points back to host folders
# TODO maybe we want a run_debug target that keeps the container after exit?

run:
	docker container run --rm --interactive --tty \
		--volume "$$HOME":"/mnt/host/home" \
		--volume "/":"/mnt/host/files" \
		--volume "$(PWD)":"/mnt/host/pwd" \
		"$(APPNAME):dev"

################################################################################
.PHONY: clean

clean:
	rm -f "$(SRCDIR)/*.pyc"
	rm -Rf "$(SRCDIR)/__pycache__"
	rm -Rf "$(BASEDIR)/__pycache__"
	rm -f "$(BASEDIR)/test/*.pyc"
	rm -Rf "$(BASEDIR)/test/__pycache__"

################################################################################
.PHONY: clobber

clobber: clean
	docker image rm --force "$(APPNAME):dev"
	docker image rm --force "$(APPNAME):latest"
