# set default shell
SHELL := $(shell which bash)
GROUP_ID = $(shell id -g)
USER_ID = $(shell id -u)
_GITHUB_API_TOKEN = $(GITHUB_API_TOKEN)
ENV = /usr/bin/env
DKC = docker-compose
DK = docker
# default shell options
.SHELLFLAGS = -c

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
default: all;   # default target

.PHONY: all gitconfig install stop rm build up ps _rm _upd

all: install

install: rm build

gitconfig:
	cp -n -v gitconfig volumes/.gitconfig

build:
	$(ENV) $(DKC) build

rm: stop _rm

_rm:
	$(ENV) $(DKC) rm -f -v

stop:
	$(ENV) $(DKC) stop

up: gitconfig _upd ps

_upd:
	$(ENV) $(DKC) up -d
	# $(ENV) $(DKC) run --rm -e GROUP_ID=$(GROUP_ID) -e USER_ID=$(USER_ID) -e GROUPNAME=$(GROUPNAME) -e USERNAME=$(USERNAME) -e HOMEDIR=$(HOMEDIR) -e GITHUB_API_TOKEN=$(_GITHUB_API_TOKEN)

ps:
	$(ENV) $(DKC) ps
