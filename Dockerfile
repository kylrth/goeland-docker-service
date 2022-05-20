FROM golang as builder

ARG TARGETARCH
ARG TAG

WORKDIR /usr/src/app
RUN git clone https://github.com/slurdge/goeland.git
WORKDIR /usr/src/app/goeland
RUN git checkout $TAG
RUN go get -v ./...
RUN python3 gox.py -osarch="linux/$TARGETARCH" -output /goeland \
    -ldflags "-X github.com/slurdge/goeland/version.GitCommit=${GIT_COMMIT}${GIT_DIRTY} -X github.com/slurdge/goeland/version.BuildDate=${BUILD_DATE} -X github.com/slurdge/goeland/internal/goeland/fetch.clientID=${IMGUR_CLIENT_ID}"

FROM gcr.io/distroless/base-debian11
COPY --from=builder --chown=1000 /goeland /goeland
USER 1000
WORKDIR /data
ENTRYPOINT ["/goeland"]
CMD ["daemon"]
