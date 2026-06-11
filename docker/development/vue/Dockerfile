FROM node:24-bookworm-slim

RUN apt update
RUN apt upgrade -y

WORKDIR /caspnetti

ENTRYPOINT npm update && npm start
