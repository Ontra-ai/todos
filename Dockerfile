
FROM ruby:2.6-slim

RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    curl \
    gnupg2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    build-essential \
    ruby-dev \
    libsqlite3-dev \
    python \
    bash \
  && apt-get upgrade -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*\
  && npm install -g yarn@1

RUN mkdir /app/
COPY package.json yarn.lock Gemfile Gemfile.lock /app/
RUN gem install bundler
WORKDIR /app/
RUN bundle install
RUN yarn install --frozen-lockfile
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]