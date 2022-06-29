FROM node:14.14.0-alpine
WORKDIR '/app'
COPY ./package.json ./
RUN npm install
RUN mkdir -p /app/node_modules/.cache && chmod -R 777 /app/node_modules/.cache
COPY . .
CMD ["npm", "run", "start"]