FROM node AS source
ARG RTTYS_VERSION=v3.6.0
RUN GIT_CURL_VERBOSE=1 GIT_TRACE=1 git clone https://github.com/zhaojh329/rttys.git /rttys/ \
    && cd /rttys \
    && git checkout $RTTYS_VERSION

FROM node AS frontend
WORKDIR /build
COPY --from=source /rttys/frontend ./
RUN npm install && npm run build

FROM golang:alpine AS backend
WORKDIR /build
COPY --from=source /rttys/ ./
COPY --from=frontend /build/dist /build/dist
RUN cp -r /build/dist /build/frontend/dist && \
    apk update && \
    apk add git gcc linux-pam-dev libc-dev && \
    go get -v github.com/rakyll/statik && \
    statik -src=/build/dist && \
    go build -ldflags "-w -s"

FROM alpine AS runtime
WORKDIR /rttys
RUN apk update && \
    apk add --no-cache linux-pam-dev
COPY  --from=backend /build/rttys /rttys/rttys
ENTRYPOINT ["/rttys/rttys"]
