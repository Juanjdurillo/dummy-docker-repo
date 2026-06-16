FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_BREAK_SYSTEM_PACKAGES=1

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        gcc \
        python3 \
        python3-pip \
        python3-dev \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip3 install -r requirements.txt
RUN pip3 install --upgrade jupyterlab==4.2.0
RUN pip3 install ipywidgets==8.1.2

ENV SHELL=/bin/bash

WORKDIR /content
COPY kepler_third_law.ipynb .
COPY kepler_third_law.png .

EXPOSE 8888
CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--allow-root", \
     "--no-browser", \
     "--NotebookApp.token=", \
     "--NotebookApp.password="]
