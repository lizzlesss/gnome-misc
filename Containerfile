# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ghcr.io/apollo-linux/apollo:latest
#FROM ghcr.io/ublue-os/silverblue-main:latest
#FROM quay.io/fedora/fedora-silverblue:latest

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    #/ctx/build.sh
    /ctx/build-fedora.sh
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
