FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
ENV app /myapp
WORKDIR ${app}
COPY . ${app}
RUN bundle check || bundle install
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3001

# Start the main process.
CMD ["rails", "server","-p", "3001", "-b", "0.0.0.0"]
