#
# Copyright (c) 2010,2011 Joyent Inc., All rights reserved.
#

DESTROOT=$(DESTDIR)/smartdc/ur-agent
ROOT=$(PWD)

all: submodules update

submodules:
	git submodule update --init

update:
	(git pull --rebase && git submodule update)

install:
	rm -rf $(DESTROOT)
	mkdir -p $(DESTROOT)/amqp/util
	/usr/bin/install -m 0555 -t $(DESTROOT) $(ROOT)/ur-agent
	/usr/bin/install -m 0444 -t $(DESTROOT) $(ROOT)/README
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/LICENSE-MIT
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/amqp-0.8.xml
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/README.md
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/package.json
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/qparser.rb
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/amqp-definitions-0-8.js
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/promise.js
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/util/delete-exchange.js
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/util/delete-queue.js
	/usr/bin/install -m 0444 -t $(DESTROOT)/amqp $(ROOT)/amqp/amqp.js

clean:
	/bin/true
