FROM continuumio/miniconda3:latest

SHELL ["/bin/bash", "-c"]

WORKDIR /root/prod_docker

COPY app .

RUN groupadd -r hume -g 433 && useradd -u 431 -r -g hume -s /sbin/nologin -c "Hume Platform User" hume
USER hume

RUN export FLASK_APP=/root/prod_docker/app/apply.py

ENTRYPOINT ["flask","run"]