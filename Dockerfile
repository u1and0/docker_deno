# Usage:
# docker run -it --rm -v `pwd`:/work -w /work u1and0/deno

FROM u1and0/zplug:latest

# Install nodejs, npm, deno
USER root

ARG TARGETPLATFORM

RUN PLATFORM=$( \
        case ${TARGETPLATFORM} in \
            linux/amd64 \) echo "x86_64";; \
            linux/arm64 \) echo "aarch_64";; \
        esac ) && \
    if [ ${PLATFORM} = "amd64" ]; then \
        pacman -Syu --noconfirm nodejs npm deno &&\
        pacman -Qtdq | xargs -r sudo pacman --noconfirm -Rcns &&\
        : "pacman -Scc の代わり"\
    elif [ ${PLATFORM} = "arm64" ]; then \
        pacman -Syu --noconfirm nodejs npm &&\
        pacman -Qtdq | xargs -r sudo pacman --noconfirm -Rcns &&\
        : "pacman -Scc の代わり" &&\
        mkdir /tmp/deno && cd /tmp/deno &&\
        curl -fsSLo https://github.com/LukeChannings/deno-arm64/releases/download/v1.37.1/deno-linux-arm64.zip &&\
        unzip deno-linux-arm64.zip &&\
        rm deno-linux-arm64.zip\
    fi


# Install typescript
RUN npm install -g typescript

LABEL maintainer="u1and0 <e01.ando60@gmail.com>"\
      description="deno / typescript env with neovim"\
      version="deno:v0.1.0"
