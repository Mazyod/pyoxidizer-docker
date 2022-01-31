ARG RUST_IMAGE=rust
FROM $RUST_IMAGE as builder
ARG VERSION=main
WORKDIR /build
RUN echo $VERSION
RUN if [[ -f /etc/alpine-release ]]; then \
        apk add --no-cache musl-dev clang; \
    fi
RUN if [ "$VERSION" = "main" ]; then \
        cargo install \
            --git https://github.com/indygreg/PyOxidizer.git \
            --branch main pyoxidizer; \
    else \
        cargo install pyoxidizer --version $VERSION; \
    fi
ENTRYPOINT [ "pyoxidizer" ]
CMD [ "build", "--system-rust", "--release" ]
