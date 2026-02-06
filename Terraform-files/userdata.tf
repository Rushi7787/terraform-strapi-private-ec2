#!/bin/bash
set -e

# Update system
yum update -y

# Install Docker
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/v2.25.0/docker-compose-linux-x86_64" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create app directory
mkdir -p /opt/strapi
cd /opt/strapi

# Create docker-compose.yml
cat <<EOF > docker-compose.yml
version: "3"
services:
  strapi:
    image: strapi/strapi
    restart: always
    environment:
      DATABASE_CLIENT: sqlite
    ports:
      - "1337:1337"
    volumes:
      - ./data:/srv/app
EOF

# Start Strapi
/usr/local/bin/docker-compose up -d
