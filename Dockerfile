FROM rails:5.0.0

MAINTAINER Maslah <hannah.masila@andela.com>

RUN mkdir -p /code
WORKDIR /code

EXPOSE 3000
CMD rails s

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./

RUN bundle install
COPY . /code
