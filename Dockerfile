FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production
RUN npm install -g pm2

COPY . .
RUN npx prisma generate

# Heroku는 $PORT 환경변수를 동적으로 할당
ENV PORT=3000
EXPOSE $PORT

# Heroku용 시작 명령
CMD ["pm2-runtime", "start", "src/app.js", "-i", "max"]