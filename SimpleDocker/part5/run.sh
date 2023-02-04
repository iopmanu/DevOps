#!/bin/bash

service nginx start
spawn-fcgi -p 8080 -f ./webserver
nginx -s reload
