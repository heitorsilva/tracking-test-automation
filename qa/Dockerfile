FROM ruby:2.6.2-slim

RUN mkdir /qa
WORKDIR /qa

COPY Gemfile Gemfile.lock /qa/

# Add Tini
ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

RUN echo 'deb http://ftp.debian.org/debian stretch-backports main' | tee /etc/apt/sources.list.d/stretch-backports.list && \
    mkdir -p /usr/share/man/man1mkdir -p /usr/share/man/man1 && \
    apt-get update && apt upgrade -qqy && \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy --no-install-recommends install build-essential git libxml2 libxml2-dev libxslt1-dev locales netcat-openbsd openjdk-11-jdk openssl software-properties-common ssh tzdata unzip vim wget zlib1g zlib1g-dev zlibc && \
    echo "en_US UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    sed -i -E 's/# (set convert-meta off)/\1/' /etc/inputrc && \
    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    mkdir -p /usr/local/etc && \
    { \
      echo 'install: --no-document'; \
      echo 'update: --no-document'; \
    } >> /usr/local/etc/gemrc && \
    gem install --no-document bundler && \
    bundle install

# QA Stuff
RUN cd /tmp && \
    wget https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip && \
    unzip BrowserStackLocal-linux-x64.zip && \
    mv BrowserStackLocal /bin/ && \
    chmod +x /bin/BrowserStackLocal && \
    wget https://github.com/browserup/browserup-proxy/releases/download/v2.0.0/browserup-proxy-2.0.0.zip && \
    unzip browserup-proxy-2.0.0.zip && \
    mv browserup-proxy-2.0.0 /usr/local/etc/ && \
    chmod +x /usr/local/etc/browserup-proxy-2.0.0/bin/browserup-proxy && \
    ln -s /usr/local/etc/browserup-proxy-2.0.0/bin/browserup-proxy /bin/browserup-proxy && \
    rm -rf *.zip

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

EXPOSE 8080-8581

CMD ["sh", "-c", "BrowserStackLocal --key $BROWSERSTACK_ACCESS_KEY --local-proxy-host $LOCAL_PROXY_HOST --local-proxy-port $LOCAL_PROXY_PORT --force-proxy --force-local --enable-logging-for-api --verbose 3"]
