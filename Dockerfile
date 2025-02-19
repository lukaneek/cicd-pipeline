FROM node as builder
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
#CMD ["node","server.js"]

#PRODUCTION
# Stage-2 Production Environment
# Install nginx in the docker container to serve the index.html and javascript files with nginx.  
FROM nginx

# Copy nginx configuration 
COPY --from=builder /app/default.conf /etc/nginx/conf.d/ 

EXPOSE 80



#CMD ["nginx", "-g", "daemon off;"]

CMD ["/usr/bin/bash", "/app/start.sh"]