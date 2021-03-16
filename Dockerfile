FROM ruby:2.7.2-slim-buster AS app

WORKDIR /app
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl libpq-dev \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && useradd --create-home ruby \
  && chown ruby:ruby -R /app

USER ruby

COPY --chown=ruby:ruby Gemfile* ./
COPY --chown=ruby:ruby bin/ ./bin

RUN chmod 0755 bin/* && bundle install --jobs $(nproc)

ARG RAILS_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    PATH="${PATH}:/home/ruby/.local/bin" \
    USER="ruby"

COPY --chown=ruby:ruby . .



EXPOSE 3001

# Start the main process.
CMD ["rails", "server","-p", "3001", "-b", "0.0.0.0"]
