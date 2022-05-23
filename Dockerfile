FROM node:alpine as installer
WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn --frozen-lockfile

FROM installer as builder
WORKDIR /app
COPY ./src ./src
COPY tsconfig.json .
RUN yarn build

FROM node:alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist .

ENV FASTIFY_ADDRESS = 0.0.0.0
ENV PORT=3000
EXPOSE 3000
CMD [ "node", "index.js" ]
