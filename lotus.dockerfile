# build container stage
FROM stirlingx/lotus-build-env:latest build-env

# branch or tag of the lotus version to build
ARG BRANCH

RUN echo "Building lotus from branch $BRANCH"

ENV RUSTFLAGS="-C target-cpu=native -g"

ENV FFI_BUILD_FROM_SOURCE=1

RUN git clone https://github.com/filecoin-project/lotus.git --depth 1 --branch $BRANCH

WORKDIR /go/lotus

RUN /bin/bash -c "source /root/.cargo/env" &&  make build
RUN make install

# runtime container stage
FROM nvidia/opencl:runtime-ubuntu18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt upgrade -y && \
    apt install mesa-opencl-icd ocl-icd-opencl-dev -y

COPY --from=build-env /usr/local/bin/lotus /usr/local/bin/lotus
COPY --from=build-env /usr/local/bin/lotus-miner /usr/local/bin/lotus-miner
COPY --from=build-env /usr/local/bin/lotus-worker /usr/local/bin/lotus-worker
COPY --from=build-env /etc/ssl/certs /etc/ssl/certs

COPY --from=build-env /lib/x86_64-linux-gnu/libdl.so.2 /lib/libdl.so.2
COPY --from=build-env /lib/x86_64-linux-gnu/libutil.so.1 /lib/libutil.so.1
COPY --from=build-env /usr/lib/x86_64-linux-gnu/libOpenCL.so.1.0.0 /lib/libOpenCL.so.1
COPY --from=build-env /lib/x86_64-linux-gnu/librt.so.1 /lib/librt.so.1
COPY --from=build-env /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/libgcc_s.so.1

COPY config/config.toml /root/config.toml
COPY scripts/entrypoint /bin/entrypoint

# API port
EXPOSE 1234/tcp

# P2P port
EXPOSE 1235/tcp

ENTRYPOINT ["/bin/entrypoint"]
