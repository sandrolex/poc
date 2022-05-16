FROM ubuntu:14.04.1 
RUN apt-get update
RUN apt-get install -y bash=4.3-6ubuntu1 --force-yes
RUN apt-get install -y build-essential vim curl wget
RUN apt-get install -y libapr1-dev libaprutil1-dev
RUN mkdir /build
RUN cd /build && wget https://archive.apache.org/dist/httpd/httpd-2.4.7.tar.gz && tar xvfz httpd-2.4.7.tar.gz
#ADD  httpd-2.4.7.tar.gz /build
WORKDIR /build/httpd-2.4.7/
RUN ./configure CFLAGS="-DBIG_SECURITY_HOLE"  --enable-cgi --enable-cgid && make && make install
#COPY index.bash /usr/local/apache2/cgi-bin/
RUN echo "#!/bin/bash\necho 'Content-type: text/html'\necho ''\necho 'CGI Bash Example'" > /usr/local/apache2/cgi-bin/test-cgi
RUN chmod 755 /usr/local/apache2/cgi-bin/test-cgi
RUN sed -i 's/daemon/root/g' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's$#LoadModule cgid_module modules/mod_cgid.so$LoadModule cgid_module modules/mod_cgid.so$g' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's/80/8080/g' /usr/local/apache2/conf/httpd.conf
WORKDIR /tmp
CMD ["/usr/local/apache2/bin/httpd", "-X"]
