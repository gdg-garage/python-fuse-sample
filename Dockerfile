FROM debian:buster-slim

RUN apt-get update && apt-get install -y python3 python3-pip fuse
COPY passthrough.py .
COPY requirements.txt .
RUN pip3 install -r requirements.txt
RUN mkdir /real
RUN mkdir /fuse