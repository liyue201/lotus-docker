# build container stage
FROM golang:1.15.2

RUN apt-get update -y && \
	apt-get install curl git mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config -y

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup-init.sh && \
	chmod +x rustup-init.sh && \
	./rustup-init.sh -y

ENV PATH="$PATH:/root/.cargo/bin"