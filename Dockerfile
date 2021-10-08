from ruby:2.7

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN gem install bundler && \
    bundle install

CMD ["ruby", "./app.rb"]

