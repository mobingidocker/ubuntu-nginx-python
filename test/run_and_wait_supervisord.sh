#!/usr/bin/env bash

CID=`docker run -d -p 80:80 ci/test`

until docker logs $CID | grep 'supervisord started' ; do echo -n . ; sleep 2 ;done

