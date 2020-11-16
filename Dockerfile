ARG ZFSBEAT_VERSION=1.0.2

FROM alpine:latest as base

ARG ZFSBEAT_VERSION

ADD https://github.com/maireanu/zfsbeat/releases/download/$ZFSBEAT_VERSION/zfsbeat /zfsbeat

RUN chmod 755 /zfsbeat

FROM gcr.io/distroless/base:latest

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG ZFSBEAT_VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="jackett-distroless" \
    org.label-schema.description="Distroless container for the zfsbeat program" \
    org.label-schema.url="https://guillaumedsde.gitlab.io/zfsbeat-distroless/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version=$ZFSBEAT_VERSION \
    org.label-schema.vcs-url="https://github.com/guillaumedsde/zfsbeat-distroless" \
    org.label-schema.vendor="guillaumedsde" \
    org.label-schema.schema-version="1.0"

COPY --from=base /zfsbeat /zfsbeat


ENTRYPOINT [ "/zfsbeat" ]