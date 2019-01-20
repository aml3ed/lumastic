FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /lumastic

ADD Gemfile Gemfile.lock /lumastic/

RUN bundle install

ADD . .
CMD ["bundle","exec","rails","server","-p","80","-b","0.0.0.0"]
