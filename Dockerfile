FROM heroku/cedar:14

RUN useradd -d /app -m app
USER app
RUN mkdir -p /app/user
WORKDIR /app/user

ENV HOME /app
ENV RUBY_ENGINE 2.2.2
ENV BUNDLER_VERSION 1.9.7
ENV NODE_ENGINE 0.10.38
ENV PORT 3000

RUN mkdir -p /app/heroku/ruby
RUN curl -s https://s3-external-1.amazonaws.com/heroku-buildpack-ruby/cedar-14/ruby-$RUBY_ENGINE.tgz | tar xz -C /app/heroku/ruby
ENV PATH /app/heroku/ruby/bin:$PATH

RUN mkdir -p /app/heroku/bundler
RUN curl -s https://s3-external-1.amazonaws.com/heroku-buildpack-ruby/bundler-$BUNDLER_VERSION.tgz | tar xz -C /app/heroku/bundler
ENV GEM_PATH /app/heroku/bundler
ENV GEM_HOME $GEM_PATH
ENV BUNDLE_APP_CONFIG $GEM_HOME
ENV PATH $GEM_PATH/bin:$PATH

RUN mkdir -p /app/heroku/node
RUN curl -s https://s3pository.heroku.com/node/v$NODE_ENGINE/node-v$NODE_ENGINE-linux-x64.tar.gz | tar --strip-components=1 -xz -C /app/heroku/node
ENV PATH /app/heroku/node/bin:$PATH

RUN mkdir -p /app/.profile.d
RUN echo "export PATH=\"/app/heroku/ruby/bin:/app/heroku/bundler/bin:/app/heroku/node/bin:\$PATH\"" > /app/.profile.d/ruby.sh
RUN echo "export GEM_PATH=\"/app/heroku/bundler\"" >> /app/.profile.d/ruby.sh
RUN echo "export GEM_HOME=\"/app/heroku/bundler\"" >> /app/.profile.d/ruby.sh
RUN echo "export BUNDLE_APP_CONFIG=\"\$GEM_HOME\"" >> /app/.profile.d/ruby.sh
RUN echo "cd /app/user" >> /app/.profile.d/ruby.sh

EXPOSE 3000

COPY Gemfile /app/user/
COPY Gemfile.lock /app/user/

USER root
RUN chown app /app/user/Gemfile.lock
USER app

RUN bundle install --jobs 4

COPY . /app/user

USER root
RUN chown -R app /app
USER app
