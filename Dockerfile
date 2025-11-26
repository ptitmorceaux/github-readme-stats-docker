FROM node:22-alpine

WORKDIR /app

COPY ./app/package*.json ./

RUN npm install && npm install express

COPY ./app ./

EXPOSE 9000

CMD ["node", "express.js"]