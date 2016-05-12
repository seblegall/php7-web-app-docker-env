#!/bin/bash

# add custom hosts entries

echo "${WEB_PORT_80_TCP_ADDR}    www.my-php-app.local" >> /etc/hosts

exec "$@"
