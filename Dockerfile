FROM ubuntu:14.04

MAINTAINER Adrien Folie, folie.adrien@gmail.com

# Set ruby version.
ENV RUBY_MAJOR 2.1
ENV RUBY_MINOR 2.1.2

# Install dependencies.
RUN apt-get update -q && \
    apt-get -qy install \
    git-core \
    curl \
    wget \
    zlib1g-dev \
    build-essential \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    python-software-properties

# Install ruby.
RUN curl -O http://ftp.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_MINOR.tar.gz && \
    tar -xzvf ruby-$RUBY_MINOR.tar.gz && \
    cd ruby-$RUBY_MINOR && \
    ./configure --disable-install-doc && \
    make && \
    make install && \
    cd .. && \
    rm -r ruby-$RUBY_MINOR ruby-$RUBY_MINOR.tar.gz && \
    echo "gem: --no-document" > /usr/local/etc/gemrc

RUN gem install bundler

RUN wget https://github.com/kenjij/newrelic_redis_plugin/archive/v1.0.1.tar.gz && \
    tar -xzvf v1.0.1.tar.gz  && \
    rm v1.0.1.tar.gz && \
    mv newrelic_redis_plugin-1.0.1 newrelic

RUN cd newrelic && bundle install

COPY newrelic_plugin.yml newrelic/config/newrelic_plugin.yml

WORKDIR newrelic

CMD ["./newrelic_redis_agent"]
