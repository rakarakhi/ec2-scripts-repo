#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y nginx
sudo systemctl start nginx 
sudo ufw allow 'nginx full'
sudo chown ubuntu:ubuntu -R /var/www/html
sudo chmod 755 /var/www/html
export INSTANCEID=`curl http://169.254.169.254//latest/meta-data/instance-id`


## Notes:
curl http://169.254.169.254//latest/meta-data/
# Output:
ami-id
ami-launch-index
ami-manifest-path
block-device-mapping/
events/
hibernation/
hostname
identity-credentials/
instance-action
instance-id
instance-life-cycle
instance-type
local-hostname
local-ipv4
mac
metrics/
network/
placement/
profile
public-hostname
public-ipv4
public-keys/
reservation-id
security-groups
services/

curl http://169.254.169.254//latest/meta-data/instance-id
curl http://169.254.169.254//latest/meta-data/instance-type
curl http://169.254.169.254//latest/meta-data/local-ipv4
curl http://169.254.169.254//latest/meta-data/public-ipv4