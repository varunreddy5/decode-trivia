FROM ruby:2.7.1
LABEL maintainer="vreddy.regalla@ufl.edu"

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends apt-transport-https

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends nodejs yarn
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app/

RUN gem install bundler
RUN bundle install
COPY . /usr/src/app/
# ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bin/rails", "s", "-b", "0.0.0.0"]