FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /lumastic

ADD Gemfile Gemfile.lock /lumastic/

RUN bundle install
EXPOSE 3000

ADD . .
CMD bundle exec rails server -p 3000 -b '0.0.0.0'
