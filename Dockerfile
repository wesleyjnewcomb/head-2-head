FROM starefossen/ruby-node:alpine
COPY Gemfile .
RUN bundle install
