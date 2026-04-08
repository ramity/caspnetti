FROM ollama/ollama:latest
RUN apt update
RUN apt upgrade -y
RUN apt install curl git -y
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH="$HOME/.local/bin:$PATH"

# Add Docker's official GPG key:
RUN apt update
RUN apt install ca-certificates curl
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

RUN apt update
RUN apt install -y docker-ce-cli

WORKDIR /caspnetti
ENTRYPOINT cd /root/.ollama && ollama serve
