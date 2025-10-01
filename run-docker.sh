#!/bin/bash

# get the correct directory (relative to this script)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# build public site with latest hugo
docker run -v "$SCRIPT_DIR:/src" hugomods/hugo:latest build

# restart nginx docker image with updated html
docker stop blog-nginx
docker rm blog-nginx
docker run --name blog-nginx --restart always -v "$SCRIPT_DIR/public:/usr/share/nginx/html:ro" -p 8008:80 -d nginx

