# Usage:
# docker run -it --rm -v `pwd`:/work -w /work u1and0/deno

FROM u1and0/zplug:latest

USER root

# Install nodejs, npm, deno, typescript
RUN pacman -Syu --noconfirm nodejs npm deno &&\
    pacman -Qtdq | xargs -r sudo pacman --noconfirm -Rcns &&\
    npm install -g typescript &&\

USER u1and0

LABEL maintainer="u1and0 <e01.ando60@gmail.com>"\
      description="deno / typescript env with neovim"\
      version="deno:v0.1.0"
