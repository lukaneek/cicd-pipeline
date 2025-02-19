#!/bin/bash

#starting nginx
/usr/sbin/nginx -g daemon off;

#starting express server
node server.js