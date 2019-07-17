FROM alpine:3.10
WORKDIR /app
# install ruby system deps
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
# install ruby app deps
COPY .gemrc $HOME
COPY Gemfile .
RUN bundle install
# install nodejs system deps
RUN apk add --no-cache \
    nodejs \
    nodejs-npm \
    && rm -rf /var/cache/apk/*
# install nodejs app deps
# copy source code
COPY src src
# compile frontend
# remove unnecessary files
# allow traffic on port 4567 for sinatra
EXPOSE 4567
# app entry point
CMD ["ruby", "src/app.rb"]
