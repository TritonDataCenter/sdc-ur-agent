#
# Copyright (c) 2010,2011 Joyent Inc., All rights reserved.
#

DESTROOT=$(DESTDIR)/joyent/ur-agent
ROOT=$(PWD)

all: submodules update

submodules:
	git submodule update --init

update:
	(git pull --rebase && git submodule update)

install:
	rm -rf $(DESTROOT)
	mkdir -p $(DESTROOT)/amqp/util
	/usr/sbin/install -m 0555 -f $(DESTROOT) $(ROOT)/ur-agent
	/usr/sbin/install -m 0444 -f $(DESTROOT) $(ROOT)/README
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/LICENSE-MIT
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/amqp-0.8.xml
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/README.md
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/package.json
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/qparser.rb
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/amqp-definitions-0-8.js
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/promise.js
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/util/delete-exchange.js
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/util/delete-queue.js
	/usr/sbin/install -m 0444 -f $(DESTROOT)/amqp $(ROOT)/amqp/amqp.js

clean:
	/bin/true
