# BUILDER STAGE

FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
CMD ["npm", "run", "build"]

# RUN STAGE

FROM nginx

# nginx 포트 매핑
EXPOSE 80
# builder stage 로부터 파일 복사
# /usr/src/app/build 디렉토리의 파일을
# /usr/share/nginx/html 디렉토리에 복사해준다.
# nginx 에서 클라이언트(브라우저)의 요청에 따라 적합한 static file을 serving 하기 위해
COPY --from=builder /usr/src/app/build /usr/share/nginx/html