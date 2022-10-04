FROM python

WORKDIR /root/prod_docker

RUN curl -sSL  | python -
ENV PATH = "${PATH}:/root/.local/bin"
COPY poetry.lock pyproject.toml /root/prod_docker/
RUN poetry update

COPY . .
EXPOSE 8000
ENTRYPOINT ["poetry","run","uvicorn","--app-dir", "app","main:app","--host", "0.0.0.0","--port","8000"]