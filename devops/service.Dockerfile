FROM python:3.9-slim
WORKDIR /var/app
RUN apt-get update -y && apt-get install -y --reinstall build-essential && python3 -m pip install --upgrade pip setuptools wheel
RUN python3 -m pip install gunicorn
COPY requirements.txt $WORKDIR
RUN apt-get install -y gcc libxml2-dev libxmlsec1-dev libxmlsec1-openssl libpq-dev libxslt-dev pkg-config default-libmysqlclient-dev
RUN python3 -m pip install -r requirements.txt
COPY ./app /var/app/app
COPY gunicorn_config.py $WORKDIR
EXPOSE 80
ENTRYPOINT ls -a && gunicorn -c gunicorn_config.py app.run:app --no-sendfile --timeout 300