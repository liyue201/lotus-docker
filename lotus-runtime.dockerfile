FROM nvidia/opencl:runtime-ubuntu18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt upgrade -y && \
    apt install mesa-opencl-icd ocl-icd-opencl-dev -y