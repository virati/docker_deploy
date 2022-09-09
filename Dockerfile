FROM python

SHELL ["/bin/bash", "-c"]

WORKDIR /root/prod_docker

COPY . .

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
ENV PATH = "${PATH}:/root/.local/bin"
RUN poetry update

RUN export FLASK_APP=/root/prod_docker/app/apply.py

ENTRYPOINT ["flask","run"]