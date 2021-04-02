FROM node:15.12.0
LABEL maintainer "nukopy <pytwbf201830@gmail.com>"

WORKDIR /app

# install system packages
RUN apt-get update -y && \
    apt-get install -y vim

# install npm packages
COPY package.json /app
COPY package-lock.json /app
RUN npm install

# add src
COPY ./ /app

CMD npm run dev
