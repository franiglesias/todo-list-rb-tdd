#!/bin/sh

# Use this script to run anything you need in the container

# Apply https://bundler.io/guides/bundler_docker_guide.html

unset BUNDLE_PATH
unset BUNDLE_BIN

# This is be kind and ensure that docker container is up and runnig
echo 'Welcome to Ruby!'

# Init a ruby project with bundler if no Gemfile
if [ ! -f Gemfile ]; then
    bundle init
fi

# Install project dependencies
bundle install

# Execute the extra commands passed in the ENTRYPOINT step of the dockerfile
exec "$@"