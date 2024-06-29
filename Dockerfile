# syntax=docker/dockerfile:1

# GO_VERSION allows overriding the version of Go to use for building the binary.
ARG GO_VERSION=1.22

# build is the stage to cross-compile the binary.
FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS build
ARG TARGETOS
ARG TARGETARCH
COPY go.mod main.go .
RUN <<-"EOT"
	set -ex
	mkdir -p /build

	GOOS=${TARGETOS} GOARCH=${TARGETARCH} CGO_ENABLED=0 go build --ldflags "-extldflags -static" -o /build/angry-unicorn -a main.go
EOT

# final is the stage containing just the binary we built.
FROM scratch AS final
# LISTEN_PORT is the tcp port on which the service is listening.
ARG LISTEN_PORT=8080

# TOP_MSG is the top message printed on the Angry Unicorn page.
ARG TOP_MSG="This page is taking way too long to load."

# TOP_MSG is the bottom message printed on the Angry Unicorn page.
ARG BOTTOM_MSG="Sorry about that. Please try refreshing and contact us if the problem persists."

ENV LISTEN_PORT=${LISTEN_PORT}
ENV TOP_MSG=${TOP_MSG}
ENV BOTTOM_MSG=${BOTTOM_MSG}
CMD ["/angry-unicorn"]
USER 1:1
COPY --from=build /build/angry-unicorn /
