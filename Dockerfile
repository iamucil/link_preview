FROM bitwalker/alpine-elixir:1.9.1

LABEL verion="0.1.0"

ENV WORKDIR=/app \
  MIX_ENV=prod \
  HEX_HTTP_CONCURRENCY=1 \
  HEX_HTTP_TIMEOUT=120 \
  APP_NAME=LinkPreview \
  ELIXIR_ERL_OPTS="+P 5000000" \
  HTTP_PORT=8080

WORKDIR ${WORKDIR}

RUN apk update \
  && apk add --no-cache ca-certificates

COPY . .

RUN rm -Rf _build deps \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mix do deps.get, compile \
  && rm -rf /var/cache/apk/* 

EXPOSE 8080/tcp

ENTRYPOINT ["mix", "run", "--no-halt"]
