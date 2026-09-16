# Multi-stage build for self-hosting. Askama templates and sqlx migrations are
# compiled/embedded into the binary; only the binary ships.

FROM rust:1-slim AS builder
WORKDIR /build
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /build/target/release/app /app/app
ENV PORT=8080
EXPOSE 8080
VOLUME ["/app/data"]
CMD ["/app/app"]
