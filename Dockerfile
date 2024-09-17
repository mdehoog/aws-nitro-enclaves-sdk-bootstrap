# nixos/nix:2.21.4
FROM nixos/nix@sha256:91b689f94a101aa67f95034dffd9a4858e85d0946f67c64dd65ed241644454b9 AS bootstrap

RUN mkdir /build
WORKDIR /build

ENV REPO=https://github.com/aws/aws-nitro-enclaves-sdk-bootstrap.git
ENV COMMIT=7614f19963e4e956493b3260fda4d62834bb281c
RUN git init && \
    git remote add origin $REPO && \
    git fetch --depth=1 origin $COMMIT && \
    git reset --hard FETCH_HEAD

RUN mkdir out
RUN nix-build -A kernel && cp -r result/* out/
RUN nix-build -A init && cp -r result/* out/

