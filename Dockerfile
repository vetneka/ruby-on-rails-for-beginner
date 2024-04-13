ARG RUBY_VERSION=3.3.0

FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

ARG RAILS_ROOT=/ruby_on_rails_for_beginners
# ARG PACKAGES="vim openssl-dev build-base curl less tzdata git bash screen gcompat"

# INFO: used commands
# apk add --no-cache [package-name]

# docker build -t ruby_on_rails_for_beginners .
# docker run -it -v $PWD:/ruby_on_rails_for_beginners ruby_on_rails_for_beginners sh

# gem install rails
# gem install sqlite3

# rails new /ruby_on_rails_for_beginners
# rails server

# find / -name sqlite -type f

ARG PACKAGES="build-essential git libvips pkg-config curl libsqlite3-0 libvips sqlite3"

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y $PACKAGES 

RUN gem install bundler

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock  ./
RUN bundle install --jobs 5

ADD . $RAILS_ROOT
ENV PATH=$RAILS_ROOT/bin:${PATH}

EXPOSE 3000
CMD bundle exec rails s -b '0.0.0.0' -p 3000