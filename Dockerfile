# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.2.0
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /app

# Install base packages (including postgresql-client)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    nodejs \
    yarn \
    postgresql-client \
    --fix-missing && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    RAILS_SERVE_STATIC_FILES="1" \
    RAILS_LOG_TO_STDOUT="1"


FROM base AS build

# Install build dependencies (including libpq-dev and postgresql)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    pkg-config \
    libpq-dev \
    postgresql \
    postgresql-contrib \
    --fix-missing && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install gems, using a shell script for variable assignment
COPY Gemfile Gemfile.lock ./
RUN sh -c 'gem install bundler:2.3.6 && \
    bundle config set --local without "development:test" && \
    bundle config set --local path "${BUNDLE_PATH}" && \
    PG_CONFIG=$(which pg_config) bundle install -j4 && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile' # Using sh -c for the entire command


COPY . .

# RUN bundle exec rails secret > /tmp/secret_key_base && \
#     RAILS_ENV=production SECRET_KEY_BASE=$(cat /tmp/secret_key_base) bundle exec rails assets:precompile && \
#     rm /tmp/secret_key_base

FROM base

COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /app /app

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash

RUN chown -R rails:rails /app
# RUN chown -R rails:rails /app/db /app/log /app/storage /app/tmp

USER rails

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s \
    CMD curl -f http://localhost:3000/ || exit 1

CMD ["bash", "-c", "bin/rails db:prepare && bin/rails server -b '0.0.0.0'"]