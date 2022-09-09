FROM python

SHELL ["/bin/bash", "-c"]

WORKDIR /root/prod_docker

COPY app .

RUN groupadd -r hume -g 433 && useradd -u 431 -r -g hume -s /sbin/nologin -c "Hume Platform User" hume
USER hume


USER hume
WORKDIR /home/hume/
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
ENV PATH = "${PATH}:/home/hume/.local/bin"

USER root
WORKDIR /root/prod_docker
RUN poetry update && poetry install

RUN export FLASK_APP=/root/prod_docker/app/apply.py

ENTRYPOINT ["flask","run"]