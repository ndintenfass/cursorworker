FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y curl git ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install Cursor CLI
RUN curl https://cursor.com/install -fsS | bash
ENV PATH="/root/.cursor/bin:$PATH"

EXPOSE 10000

CMD ["agent", "worker", "start", "--management-addr", ":10000"]
