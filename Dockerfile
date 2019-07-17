FROM alpine:latest
WORKDIR /app
# install system deps
RUN \
    apk update \
    && apk upgrade \
    && apk add --no-cache \
    ruby \
    ruby-dev \
    ruby-bundler \
    ruby-json \
    ruby-bigdecimal \
    libssl1.1 \
    libc6-compat \
    mysql-dev \
    build-base \
    mariadb-dev \
    && rm -rf /var/cache/apk/*
# install ruby deps
COPY .gemrc $HOME
COPY Gemfile .
RUN bundle install
# copy source code
COPY src src
# allow traffic on port 4567 for sinatra
EXPOSE 4567
# app entry point
CMD ["ruby", "src/app.rb"]
