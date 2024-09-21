FROM public.ecr.aws/lambda/nodejs:18

ARG PROXY_URLS_FILE_NAME

COPY package.json /var/task/
COPY proxy.js /var/task/
COPY ${PROXY_URLS_FILE_NAME} /var/task/
RUN npm install
CMD [ "proxy.lambdaHandler" ]
