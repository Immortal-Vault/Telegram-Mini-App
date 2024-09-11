FROM node:18 AS build

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

ARG VITE_APP_STAGE
ENV VITE_APP_STAGE=$VITE_APP_STAGE

RUN yarn build

FROM node:18-alpine

RUN yarn global add serve

WORKDIR /app

COPY --from=build /app/dist ./dist

EXPOSE 3000

CMD ["serve", "-s", "dist"]
