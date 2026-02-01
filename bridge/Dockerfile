# nanobot WhatsApp Bridge
FROM node:20-slim

WORKDIR /app

COPY package*.json ./
COPY tsconfig.json ./
COPY src/ ./src/

RUN npm install && npm run build

ENV BRIDGE_PORT=3001
EXPOSE 3001

CMD ["node", "dist/index.js"]
