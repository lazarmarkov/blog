FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    curl \
    gnupg2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

EXPOSE 3000

CMD ["./bin/rails", "s", "-b", "0.0.0.0"]
