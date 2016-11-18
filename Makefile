###========================================================================
### File: Makefile
###
###
### Author(s):
###   - Chris Luo <chris.luo@derivco.se>
###
### Copyright (c) 2016 - MIT
###========================================================================
.PHONY: all build build-current build-latest push push-current push-latest


DKR ?= $(shell which docker)
DKR_REGISTRY   ?=
DKR_REPOSITORY ?= golang
DKR_IMAGE      ?= golang-dev
DKR_TAG        ?= $(shell git describe --tags 2> /dev/null || echo dev)
DKR_BUILD_OPTS ?=

all: build

build: build-current build-latest

build-current: ; $(DKR) build $(DKR_BUILD_OPTS) -t $(DKR_REPOSITORY)/$(DKR_IMAGE):$(DKR_TAG) .

build-latest: ; $(DKR) build $(DKR_BUILD_OPTS) -t $(DKR_REPOSITORY)/$(DKR_IMAGE):latest .

ifneq ($(strip $(DKR_REGISTRY)),)
	push: | push-current push-latest

push-current:
	$(DKR) tag $(DKR_REPOSITORY)/$(DKR_IMAGE):$(DKR_TAG) $(DKR_REGISTRY)/$(DKR_REPOSITORY)/$(DKR_IMAGE):$(DKR_TAG)
	$(DKR) push $(DKR_REGISTRY)/$(DKR_REPOSITORY)/$(DKR_IMAGE):$(DKR_TAG)

push-latest:
	$(DKR) tag $(DKR_REPOSITORY)/$(DKR_IMAGE):latest $(DKR_REGISTRY)/$(DKR_REPOSITORY)/$(DKR_IMAGE):latest
	$(DKR) push $(DKR_REGISTRY)/$(DKR_REPOSITORY)/$(DKR_IMAGE):latest
endif
