FROM python:3.8-slim-buster

WORKDIR /root/prod_docker
## Install basic system commands

RUN apt-get update && apt-get install -y curl
## Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH = "${PATH}:/root/.local/bin"
COPY poetry.lock pyproject.toml /root/prod_docker/
RUN poetry update

## Copy app into container
COPY . .
EXPOSE 8000
ENTRYPOINT ["poetry","run","uvicorn","--app-dir", "app","main:app","--host", "0.0.0.0","--port","8000"]