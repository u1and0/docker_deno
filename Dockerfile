# Usage:
# docker run -it --rm -v `pwd`:/work -w /work u1and0/deno

FROM u1and0/zplug:arm64

# Install nodejs, npm
USER root
RUN pacman -Syu --noconfirm nodejs npm jq unzip &&\
    : "pacman -Scc の代わり" &&\
    pacman -Qtdq | xargs -r pacman --noconfirm -Rcns

# Intall deno binary
WORKDIR /tmp/deno
RUN DENO_LATEST_TAG=$(curl -s https://api.github.com/repos/LukeChannings/deno-arm64/tags | jq -r '.[0].name') &&\
    echo ${DENO_LATEST_TAG} &&\
    curl -fsSLo deno-linux-arm64.zip https://github.com/LukeChannings/deno-arm64/releases/download/${DENO_LATEST_TAG}/deno-linux-arm64.zip &&\
    unzip deno-linux-arm64.zip &&\
    mv ./deno /usr/bin/ &&\
    rm deno-linux-arm64.zip

# Install typescript
RUN npm install -g typescript

USER u1and0
WORKDIR /home/u1and0
LABEL maintainer="u1and0 <e01.ando60@gmail.com>"\
  description="deno / typescript env with neovim"\
  version="deno:v0.2.0"
