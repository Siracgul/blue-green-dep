#!/bin/bash

REV_PROXY_IP="13.61.19.221"
PREV_TARGET_IP="13.60.64.217"  # GREEN değil de BLUE IP'si

ssh -o StrictHostKeyChecking=no -i bl-gr-key.pem ubuntu@$REV_PROXY_IP << EOF
sudo bash -c 'cat > /etc/nginx/sites-available/default << NGINXCONF
server {
    listen 80;
    location / {
        proxy_pass http://$PREV_TARGET_IP;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
NGINXCONF

sudo systemctl restart nginx
'
EOF
