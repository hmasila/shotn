FROM ruby:2.3.0

MAINTAINER Maslah <hannah.masila@andela.com>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir /shot
WORKDIR /shot

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock /shot/

RUN bundle install
COPY . /shot
