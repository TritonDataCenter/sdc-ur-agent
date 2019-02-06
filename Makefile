#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

#
# Copyright 2015 Joyent, Inc.
#

DESTROOT=$(DESTDIR)/smartdc
ROOT=$(PWD)
UNAME=$(shell uname -s)
JSSTYLE = $(ROOT)/deps/jsstyle/jsstyle
JSLINT_DIR = $(ROOT)/deps/javascriptlint
JSLINT = $(JSLINT_DIR)/build/install/jsl
JSSTYLE_OPTS = -o indent=4,strict-indent=1,doxygen,unparenthesized-return=0,continuation-at-front=1,leading-right-paren-ok=1
JS_CHECK_TARGETS=\
    ur-agent

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

mancheck_conf:

install:
	rm -rf $(DESTROOT)/node_modules/amqp
	rm -rf $(DESTROOT)/node_modules/triton-netconfig
	rm -rf $(DESTROOT)/ur-agent
	mkdir -p $(DESTROOT)/ur-agent
	mkdir -p $(DESTROOT)/node_modules/amqp/util
	mkdir -p $(DESTROOT)/node_modules/amqp/lib
	mkdir -p $(DESTROOT)/node_modules/amqp/node_modules/lodash/dist
	mkdir -p $(DESTROOT)/node_modules/amqp/node_modules/longjohn/dist
	mkdir -p $(DESTROOT)/node_modules/triton-netconfig/lib
	mkdir -p $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/assert-plus
	mkdir -p $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/clone
	$(INSTALL) -m 0555 $(INSTALL_FLAG) $(DESTROOT)/ur-agent $(ROOT)/ur-agent
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/ur-agent $(ROOT)/amqp-plus.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/ur-agent $(ROOT)/README.md
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/amqp-0-9-1.xml
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/amqp-0-9-1-rabbit.xml
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/amqp.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/History.md
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/jspack.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/LICENSE-MIT
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/package.json
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/qparser.rb
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp $(ROOT)/node_modules/amqp/README.md
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/definitions.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/queue.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/debug.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/channel.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/amqp-definitions-0-9-1.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/constants.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/serializer.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/parser.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/promise.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/exchange.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/message.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/lib $(ROOT)/node_modules/amqp/lib/connection.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/node_modules/lodash $(ROOT)/node_modules/amqp/node_modules/lodash/package.json
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/node_modules/lodash $(ROOT)/node_modules/amqp/node_modules/lodash/README.md
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/node_modules/lodash/dist $(ROOT)/node_modules/amqp/node_modules/lodash/dist/lodash.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/node_modules/longjohn $(ROOT)/node_modules/amqp/node_modules/longjohn/LICENSE-MIT
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/node_modules/longjohn $(ROOT)/node_modules/amqp/node_modules/longjohn/README.md
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/node_modules/longjohn $(ROOT)/node_modules/amqp/node_modules/longjohn/package.json
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/node_modules/longjohn/dist $(ROOT)/node_modules/amqp/node_modules/longjohn/dist/longjohn.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/util $(ROOT)/node_modules/amqp/util/delete-exchange.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/amqp/util $(ROOT)/node_modules/amqp/util/delete-queue.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig $(ROOT)/node_modules/triton-netconfig/package.json
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig $(ROOT)/node_modules/triton-netconfig/LICENSE
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig/lib $(ROOT)/node_modules/triton-netconfig/lib/index.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr $(ROOT)/node_modules/triton-netconfig/node_modules/ip6addr/LICENSE
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr $(ROOT)/node_modules/triton-netconfig/node_modules/ip6addr/ip6addr.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr $(ROOT)/node_modules/triton-netconfig/node_modules/ip6addr/package.json
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/assert-plus $(ROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/assert-plus/assert.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/assert-plus $(ROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/assert-plus/package.json
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/clone $(ROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/clone/LICENSE
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/clone $(ROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/clone/clone.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/clone $(ROOT)/node_modules/triton-netconfig/node_modules/ip6addr/node_modules/clone/package.json

clean:
	/bin/true

check: $(JSLINT)
	@printf "\n==> Running JavaScriptLint...\n"
	@$(JSLINT) --nologo --conf=$(ROOT)/etc/jsl.node.conf \
		$(JS_CHECK_TARGETS)
	@printf "\n==> Running jsstyle...\n"
	@# jsstyle doesn't echo as it goes so we add an echo to each line below
	(for file in $(JS_CHECK_TARGETS); do \
    echo $(PWD)/$$file; \
    $(JSSTYLE) $(JSSTYLE_OPTS) $$file; \
    [[ $$? == "0" ]] || exit 1; \
done)
	@printf "\nJS style ok!\n"

$(JSLINT): submodules
	(cd $(JSLINT_DIR); make CC=gcc install)

.PHONY: manifest mancheck_conf
