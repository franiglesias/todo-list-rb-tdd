FROM ruby:2.7.2-alpine

# We use an official ruby image based on alpine as starting point.

# Set or change some environment variables in order to make it easy configure docker to particular use cases
# Apply https://bundler.io/guides/bundler_docker_guide.html

ENV PORT=3000 \
    APP_DIR="/home/app" \
    GEM_HOME="/usr/local/bundle" \
    PATH=$GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH \
    USERNAME="rubycon"

# Install system dependencies needed to build and install gems

RUN apk add nodejs && apk add --virtual build-dependencies build-base gcc wget git
RUN gem install bundler

# Set the app directory and expose desired port

WORKDIR $APP_DIR

# Create a user in the container and ensure that it is the owner of files

RUN adduser -D $USERNAME && chown -R $USERNAME $GEM_HOME

# Copy project files to the container ensuring that user will be the owner

COPY --chown=$USERNAME . $APP_DIR/

# Set the created user as current user in container

USER $USERNAME

# Execute this script when the container is up, and jump into the shell

EXPOSE $PORT

ENTRYPOINT [ "./docker/entrypoint.sh", "/bin/sh" ]