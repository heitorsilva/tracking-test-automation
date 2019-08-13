FROM ruby:2.6.2-alpine

RUN mkdir /api
WORKDIR /api

ENV PAGER='busybox more'

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_NUMERIC=en_US.UTF-8 \
    LC_TIME=en_US.UTF-8 \
    LC_COLLATE=en_US.UTF-8 \
    LC_MONETARY=en_US.UTF-8 \
    LC_MESSAGES=en_US.UTF-8 \
    LC_PAPER=en_US.UTF-8 \
    LC_NAME=en_US.UTF-8 \
    LC_ADDRESS=en_US.UTF-8 \
    LC_TELEPHONE=en_US.UTF-8 \
    LC_MEASUREMENT=en_US.UTF-8 \
    LC_IDENTIFICATION=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

COPY Gemfile Gemfile.lock /api/

RUN apk add --update --no-cache autoconf automake build-base ca-certificates gcc git openssh openssl tzdata vim && \
    cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    echo "Europe/Berlin" > /etc/timezone && \
    echo 'gem: --no-document' > ~/.gemrc && \
    gem install --no-document bundler && \
    bundle install

EXPOSE 3000

CMD ["rackup", "--host", "0.0.0.0", "--port", "3000", "config.ru"]
