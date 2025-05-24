#!/bin/bash

REV_PROXY_IP="13.61.19.221"
NEW_TARGET_IP="13.49.240.8"

ssh -o StrictHostKeyChecking=no -i bl-gr-key.pem ubuntu@$REV_PROXY_IP << EOF
sudo bash -c 'cat > /tmp/revproxy.conf << NGINXCONF
server {
    listen 80;
    location / {
        proxy_pass http://$NEW_TARGET_IP;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
NGINXCONF

sudo mv /tmp/revproxy.conf /etc/nginx/sites-available/default
sudo nginx -t && sudo systemctl restart nginx
'
EOF
