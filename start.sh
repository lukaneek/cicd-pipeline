#!/bin/bash

#starting nginx
nginx -g "daemon off;"

#starting express server
node server.js