FROM hexpm/elixir:1.11.0-erlang-23.1.1-alpine-3.12.0 as build

# install build dependencies
RUN apk add --no-cache --update git build-base nodejs yarn

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get
RUN mix deps.compile

# build assets
# need to copy lib/ here so PurgeCSS can look at the phoenix views and templates to find CSS classes
COPY assets assets
COPY lib lib
RUN cd assets && yarn install && NODE_ENV=production yarn run webpack --mode production
RUN mix phx.digest

# build project
COPY priv priv
COPY lib lib
RUN mix compile

# build release
COPY rel rel
RUN mix release

# prepare release image
FROM alpine:3.12.0 AS app
RUN apk add --no-cache --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/hexpm ./
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app
