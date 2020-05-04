FROM golang:1.14-alpine AS build

ARG PROJECT=github.com/thaJeztah/angry-unicorn
ARG PROJECT_PATH=/go/src/${PROJECT}
ENV CGO_ENABLED=0
WORKDIR $PROJECT_PATH
RUN mkdir -p /build
COPY main.go .

RUN go build \
	  --ldflags "-extldflags -static" \
	  -o /build/angry-unicorn -a main.go

FROM scratch
ENV LISTEN_PORT=8080
ENV TOP_MSG="This page is taking way too long to load."
ENV BOTTOM_MSG="Sorry about that. Please try refreshing and contact us if the problem persists."
CMD ["/angry-unicorn"]
USER 1:1
COPY --from=build /build/angry-unicorn /
