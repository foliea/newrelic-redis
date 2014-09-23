## newrelic-redis

This repository contains `Dockerfile` of NewRelic redis agent for docker's automated build
published to the public docker hub registry.

This agent is meant to monitor a redis instance running in another docker container.

You don't need to bind a port of your redis container to the outside world, this agent will
access any redis container through the docker link system.

## Base Docker Image

* [ubuntu 14.04](https://registry.hub.docker.com/_/ubuntu/)

## Installation

1. Install [docker](http://www.docker.com).

2. Download [automated build](https://registry.hub.docker.com/u/dockerfile/redis) from public 
[docker hub registry](https://registry.hub.docker.com/):

    `docker pull foliea/newrelic-redis`

## Usage

First, run a redis instance inside a docker container:

    docker run -d --name redis -p 6379:6379 dockerfile/redis

Then, run the agent with your NewRelic License Key and the app name of your choice:

    docker run -ti -e NEWRELIC_LICENSE_KEY=55691eef66890aef9f0f0856f32d5ff2dc24a96f -e NEWRELIC_APP_NAME="redis-dev" --link redis:redis newrelic-redis
