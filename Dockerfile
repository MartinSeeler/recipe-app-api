FROM python:3.7-alpine
MAINTAINER developer@chasmo.de

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

# Install dependencies for our requirements.txt file
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev

# Install python packages
RUN pip install -r /requirements.txt

# Delete temporary requirements dependencies
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
