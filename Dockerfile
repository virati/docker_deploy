FROM python:3.8-slim-buster as requirements-stage

WORKDIR /tmp
RUN apt-get update && apt-get install curl -y
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
ENV PATH = "${PATH}:/root/.local/bin"
COPY poetry.lock pyproject.toml /tmp/
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes


FROM python:3.8-slim-buster
USER root

COPY --from=requirements-stage /tmp/requirements.txt /root/prod_docker/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /root/prod_docker/requirements.txt
RUN pip install uvicorn
COPY . .
ENV PATH = "${PATH}:/root/.local/bin"
EXPOSE 8000
ENTRYPOINT ["uvicorn","--app-dir", "app","main:app","--host", "0.0.0.0","--port","8000"]