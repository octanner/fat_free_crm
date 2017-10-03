FROM quay.octanner.io/base/oct-ruby

ENV APP_DIR=/app
RUN mkdir -p ${APP_DIR}
ADD . ${APP_DIR}
WORKDIR ${APP_DIR}

RUN bundle exec rake db:migrate && rake ffcrm:setup:admin USERNAME=admin PASSWORD=password EMAIL=admin@example.com

# RUN bin/rails db:environment:set RAILS_ENV=production
# RUN bin/rails db:migrate RAILS_ENV=production \
# RUN bin/rails assets:precompile \
# RUN bin/rails server -e production -p 5000

# ARG RUBYGEMS_VERSION=2.6.13
# ENV RUBYGEMS_VERSION=2.6.13
# 
# RUN gem install bundler
# 
# RUN LD_LIBRARY_PATH=${LD_LIBRARY_PATH} gem update --system $RUBYGEMS_VERSION --verbose
# 
# RUN bundle config --global frozen 1
# RUN bundle config --global --without development test
# RUN mkdir -p /gems
# 
# WORKDIR /gems
# ADD Gemfile Gemfile
# ADD Gemfile.lock Gemfile.lock
# RUN LD_LIBRARY_PATH=${LD_LIBRARY_PATH} bundle install --without development test
# 
# ENV APP_DIR=/app
# RUN mkdir -p ${APP_DIR}
# 
# RUN ln -sF /gems/.bundle /app/.bundle
# RUN ln -sF /gems/vendor /app/vendor
# WORKDIR ${APP_DIR}
# ADD . ${APP_DIR}
# 
# COPY Gemfile .
# COPY Gemfile.lock .
# 
# COPY . .
# 
# CMD ./startup.sh
# ------- fatfree crm file
# Usage:
# docker-compose up
# docker-compose exec web bundle exec rake db:create db:schema:load ffcrm:demo:load assets:precompile

# FROM phusion/passenger-ruby24
# MAINTAINER Steve Kenworthy
# 
# ENV HOME /home/app
# 
# ADD . /home/app
# WORKDIR /home/app
# 
# RUN apt-get update \
#   && apt-get install -y imagemagick firefox \
#   && apt-get autoremove -y \
#   && cp config/database.postgres.docker.yml config/database.yml \
#   && chown -R app:app /home/app \
#   && rm -f /etc/service/nginx/down /etc/nginx/sites-enabled/default \
#   && cp .docker/nginx/sites-enabled/ffcrm.conf /etc/nginx/sites-enabled/ffcrm.conf \
#   && bundle install --deployment
