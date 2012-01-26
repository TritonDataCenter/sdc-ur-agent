#
# Copyright (c) 2010,2011 Joyent Inc., All rights reserved.
#

DESTROOT=$(DESTDIR)/smartdc
ROOT=$(PWD)
UNAME=$(shell uname -s)

ifeq ($(UNAME),Linux)
    INSTALL=/usr/bin/install
    INSTALL_FLAG=-t
else
    INSTALL=/usr/sbin/install
    INSTALL_FLAG=-f
endif

world: submodules

submodules:
	git submodule update --init

update:
	(git pull --rebase && git submodule update)

manifest:
	cp manifest $(DESTDIR)/$(DESTNAME)

install:
	rm -rf $(DESTROOT)/node_modules/amqp
	rm -rf $(DESTROOT)/ur-agent
	mkdir -p $(DESTROOT)/ur-agent
	mkdir -p $(DESTROOT)/node_modules/amqp/util
	$(INSTALL) -m 0555 $(INSTALL_FLAG) $(DESTROOT)/ur-agent $(ROOT)/ur-agent
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/ur-agent $(ROOT)/README
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/amqp/LICENSE-MIT
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/amqp/amqp-0.8.xml
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/amqp/README.md
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/amqp/package.json
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/amqp/qparser.rb
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/amqp/amqp-definitions-0-8.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/amqp/promise.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/util $(ROOT)/amqp/util/delete-exchange.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/util $(ROOT)/amqp/util/delete-queue.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/amqp/amqp.js

clean:
	/bin/true

.PHONY: manifest
