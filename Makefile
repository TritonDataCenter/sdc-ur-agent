#
# Copyright (c) 2010,2011 Joyent Inc., All rights reserved.
#

DESTROOT=$(DESTDIR)/smartdc/ur-agent
ROOT=$(PWD)
UNAME=$(shell uname -s)

ifeq ($(UNAME),Linux)
    INSTALL=/usr/bin/install
    INSTALL_FLAG=-t
else
    INSTALL=/usr/sbin/install
    INSTALL_FLAG=-f
endif

all: submodules update

submodules:
	git submodule update --init

update:
	(git pull --rebase && git submodule update)

install:
	rm -rf $(DESTROOT)
	mkdir -p $(DESTROOT)/amqp/util
	$(INSTALL) -m 0555 $(INSTALL_FLAG) $(DESTROOT) $(ROOT)/ur-agent
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT) $(ROOT)/README
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/LICENSE-MIT
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/amqp-0-9-1.xml
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/README.md
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/package.json
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/qparser.rb
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/amqp-definitions-0-9-1.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/promise.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/util/delete-exchange.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/util/delete-queue.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/amqp $(ROOT)/amqp/amqp.js

clean:
	/bin/true
