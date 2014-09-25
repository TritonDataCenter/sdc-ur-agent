<!--
    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->

<!--
    Copyright (c) 2014, Joyent, Inc.
-->

# sdc-ur-agent

This repository is part of the Joyent SmartDataCenter project (SDC).  For
contribution guidelines, issues, and general documentation, visit the main
[SDC](http://github.com/joyent/sdc) project page.


# Overview

When an SmartDataCenter server starts up, it will require a way of
setting up the server, boot-strapping various sub-systems such as zpool
creation, agents, etc, based on the configuration and role of the machine. The
node agent Ur, will listen on AMQP for scripts to execute.

It's important to note, however, that we will not be able to update the
operating system live image, so the Ur agent must be reasonably future proof.
To that end, it should be as simple as possible to then load additional agents
with more logic at a later time.


# What it does

The Ur agent connects to an AMQP broker, emits a message to signal it is
listening and waits. The headnode will then send scripts to be executed on the
Node (identified by said ID), with Ur replying back with the process return
code and the script's captured STDOUT and STDERR.

    - start up
    - emit "start up" message

    - receive messages with script to execute
    - execute script
    - reply with script exit code and captured stdout and stderr
    - repeat


# How it works

When a compute node starts up, Ur will be one of the first processes running.
Once it has started, the Ur agent will post a message to AMQP. This message is
simply to indicate, "Hey\! I have started up and am ready to be told what to
do". 

At this point, the headnode will take note that this new node exists and willk
now a little bit about its configuration. 

From this point on the headnode can use Ur for setting up the server, reading
configuration etc.

    - Ur starts up
    - looks up broker details
    - connects to broker
    - emits start up message containing sysinfo payload
    - headnode records node information


# Interaction

In these examples, <node-id> should be the UUID of the machine as obtained
from the "/usr/bin/sysinfo" script.

## Computenode Start

On start up, Ur will execute the sysinfo utility and publish a message to AMQP with this information.

    ==> routing-key: ur.startup.<node-id>
    
    {
      "Live Image": "20140905T202142Z",
      "System Type": "SunOS",
      ...
    }


## Executing Commands on Server with Ur

Routing keys for Ur requests should contain a unique token, {{request-id}}, so
that when we reply back we can re-use this token to indentify which command
this was a reply to.

### Execute a file

    <== routing-key: ur.execute.<node-id>.<request-id>

    { type: "file"
    , file: "scripts/pools.sh"
    , timestamp: "2010-11-10T..."
    }

### Execute an arbitrary string

    <== routing-key: ur.execute.<node-id>.<request-id>

    { type: "script"
    , script: "#!/bin/bash\necho hello world\nexit 0"
    , timestamp: "2010-11-10T..."
    }

### Ur execution replies:

On reply to an `execute` command:

    ==> routing-key: ur.execute-reply.<node-id>.<the-request-id>

    { exit_status: 0
    , stdout: "hello world\n";
    , stderr: ""
    }


# Development

    git clone git@github.com:joyent/sdc-ur-agent.git
    cd sdc-ur-agent
    git submodule update --init


## About Ur

Desolate and Forsaken, Eerily Moaning Dark Winds
Murmur Incantations, Dusk Calls Forth Shadows
Spirits of the Glorious Dead Lingering, Bound to this Place
They Whisper of Untold Sagas, of Long Dead Cities
the Seven Shining Cities Sacred to the Aphkhallu
of Ages Past when the World was Young
When Babylon was Blessed of Marduk
and the Sound of her Armies was the Blare of Ominous War Horns
and the Clash of Immortal Cymbals
of Bronze Gates Arrayed in Splendour
and Magnificent Walls of Sunbaked Brick of Temples of Marble
and Bloodstained Altars, Long Before the Jeweled Throne of Ur
Fell Silent and Turned to Dust
Beneath the Endless Shifting Sands
and the Inevitable Vengeance of the Elements

-- Nile - To Dream of Ur
