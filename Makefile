#
# Copyright (c) 2010,2011 Joyent Inc., All rights reserved.
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

install:
	rm -rf $(DESTROOT)/node_modules/amqp
	rm -rf $(DESTROOT)/ur-agent
	mkdir -p $(DESTROOT)/ur-agent
	mkdir -p $(DESTROOT)/node_modules/amqp/util
	$(INSTALL) -m 0555 $(INSTALL_FLAG) $(DESTROOT)/ur-agent $(ROOT)/ur-agent
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/ur-agent $(ROOT)/amqp-plus.js
	$(INSTALL) -m 0444 $(INSTALL_FLAG) $(DESTROOT)/ur-agent $(ROOT)/README
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

.PHONY: manifest
