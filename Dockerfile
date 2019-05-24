FROM ruby:2.5.0

RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client build-essential libpq-dev

RUN mkdir /file_management_app
WORKDIR /file_management_app

COPY Gemfile /file_management_app/Gemfile
COPY Gemfile.lock /file_management_app/Gemfile.lock
RUN bundle install

COPY . /file_management_app
