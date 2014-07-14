#!/usr/bin/env bash

# Ensure system log has started before allowing OpenLDAP to start
sv start syslog-ng || exit 1
sleep 1

# Start slapd in foreground, with general-purpose logging (not sure if
# this goes anywhere yet)
exec /usr/sbin/slapd -d 32768
