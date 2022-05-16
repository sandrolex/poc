#/bin/bash

# apache stub app 
sudo docker run -d --network pocnet --ip 172.18.0.40 sandrolex2/stub

# vuln apache
sudo docker run -d --network pocnet --ip 172.18.0.22 sandrolex2/poc

# proxy
sudo docker run -d --network pocnet --ip 172.18.0.23 -p 443:443 sandrolex2/rproxy-tls

