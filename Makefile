.DEFAULT_GOAL := help

# Vars
BASE=$(pwd)
SERVICE_NAME=atm10.riipeckx.io.service
RCON_PASS=$(shell grep "rcon.password" server.properties | cut -d '=' -f 2)

ifeq (console,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

help: # Print this help message
	@grep -E '^[a-zA-Z0-9_]+:.*#.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*#"} {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

start: # Start Minecraft server
	@systemctl start $(SERVICE_NAME)

dev: # Start development Minecraft server
	/usr/bin/sh start.sh

stop: # Stop Minecraft server
	@systemctl stop $(SERVICE_NAME)

status: # Get Minecraft server status
	@systemctl status $(SERVICE_NAME)

console: # Connect to RCON console
	@/usr/bin/mcrcon -H localhost -p 25575 -P $(RCON_PASS) $(RUN_ARGS)

output: # Follow the server logs
	@/usr/bin/tail -f ./logs/latest.log

clean:
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
	@rm -rf $(cat .gitignore) 2>/dev/null