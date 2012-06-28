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
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp-plus.js $(ROOT)/amqp-plus.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/README $(ROOT)/README
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/LICENSE-MIT
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/amqp-0-9-1.xml
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/amqp-definitions-0-9-1.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/amqp.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/History.md
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/jspack.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/README.md
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/package.json
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/qparser.rb
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/promise.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/util $(ROOT)/node_modules/amqp/util/delete-exchange.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/util $(ROOT)/node_modules/amqp/util/delete-queue.js

clean:
	/bin/true

.PHONY: manifest
