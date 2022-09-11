FROM python

SHELL ["/bin/bash", "-c"]

WORKDIR /root/prod_docker

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
ENV PATH = "${PATH}:/root/.local/bin"
COPY poetry.lock pyproject.toml /root/prod_docker/
RUN poetry update
RUN poetry self add poetry-dotenv-plugin

COPY . .
#RUN export FLASK_APP=/root/prod_docker/app/apply.py
EXPOSE 5000
#ENTRYPOINT ["poetry","run", "python3","-m", "flask","run","--host=0.0.0.0"]
ENTRYPOINT ["poetry","run","python3","/root/prod_docker/app/app.py"]