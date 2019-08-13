FROM node:lts-alpine

RUN mkdir /web
WORKDIR /web

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

COPY package.json yarn.lock /web/

RUN apk add --update --no-cache autoconf automake build-base ca-certificates gcc git openssh openssl tzdata vim yarn && \
    cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    echo "Europe/Berlin" > /etc/timezone && \
    yarn global add @vue/cli

EXPOSE 8000

CMD ["yarn", "run", "serve", "--host", "0.0.0.0", "--port", "8000"]
