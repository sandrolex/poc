FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y nginx vim curl wget 
RUN unlink /etc/nginx/sites-enabled/default
COPY rproxy.conf /etc/nginx/sites-available/rproxy.conf
RUN ln -s /etc/nginx/sites-available/rproxy.conf /etc/nginx/sites-enabled/rproxy.conf
RUN mkdir -p /root/certs
COPY certs/rproxy-server.crt /root/certs/rproxy-server.crt
COPY certs/rproxy-server.key /root/certs/rproxy-server.key
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
