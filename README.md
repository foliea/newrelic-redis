# newrelic-redis

This repository contains `Dockerfile` of  New Relic redis agent for docker's automated build
published to the public docker hub registry.

This agent is meant to monitor a redis instance with `New Relic`, using 
[newrelic_redis_plugin](https://github.com/kenjij/newrelic_redis_plugin).

You don't need to bind a port of your redis container to the outside world, this agent will
access any redis container through the docker link system.

## Base Docker Image

* [ubuntu 14.04](https://registry.hub.docker.com/_/ubuntu/)

## Sources

* [GitHub](https://github.com/folieadrien/newrelic-redis)

## Installation

1. Install [docker](http://www.docker.com).

2. Download [automated build](https://registry.hub.docker.com/u/foliea/newrelic-redis) from public 
[docker hub registry](https://registry.hub.docker.com/):

    `docker pull foliea/newrelic-redis`

## Usage

First, run a redis instance inside a docker container:

    docker run -d --name redis dockerfile/redis

Then, run the agent with your **New Relic License Key** and the app name of your choice:

    docker run -d -e NEWRELIC_LICENSE_KEY=<your license key> \
                  -e NEWRELIC_APP_NAME=<name> \
                  --link redis:redis foliea/newrelic-redis
    
Or, if you want to monitor a specific redis instance (even one running outside a container):

    docker run -d -e NEWRELIC_LICENSE_KEY=<your license key> \
                  -e NEWRELIC_APP_NAME=<name> \
                  -e REDIS_PORT=<redis url> foliea/newrelic-redis
                  
## Environment variables

* `DATABASE`: Database to monitor (default db0).

Not yet implemented:

* `PASSWORD`: Database password (default empty).
