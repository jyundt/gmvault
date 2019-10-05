FROM python:2.7.15-alpine as builder

WORKDIR /src

COPY . .

RUN apk add --no-cache make && \
    make gmv-pypi-dist

FROM python:2.7.15-alpine

COPY --from=builder /src/build/*.gz /build/

RUN apk add --no-cache bash && \
    pip install /build/*

ENTRYPOINT ["/usr/local/bin/gmvault"]
