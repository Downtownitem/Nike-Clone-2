FROM node:18-alpine

WORKDIR /app

COPY package.json /app
COPY package-lock.json /app
RUN npm install

RUN npm install -g nodemon

EXPOSE 8001

CMD ["node", "index.js"]