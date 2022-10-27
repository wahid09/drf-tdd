#FROM python:3.9-alpine
#MAINTAINER ZahanaraSoft
#
#ENV PYTHONUNBUFFERED 1
#
#COPY ./requirements.txt /requirements.txt
#RUN pip install -r /requirements.txt
#
#RUN mkdir /App
#WORKDIR /app
#COPY ./app/ /app
#
#RUN adduser -D user
#USER user
FROM python:3.9-alpine
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
     gcc libc-dev linux-headers postgresql-dev
RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps
COPY . /app

#CMD python manage.py runserver 0.0.0.0:8000