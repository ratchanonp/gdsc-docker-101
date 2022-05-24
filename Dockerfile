FROM node:alpine as installer
WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn --frozen-lockfile

FROM installer as builder
WORKDIR /app
COPY . .
RUN yarn build

FROM node:alpine as runner
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist .

EXPOSE 3000
CMD [ "node", "index.js" ]
