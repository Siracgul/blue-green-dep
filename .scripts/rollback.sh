#!/bin/bash

# Variables
REV_PROXY_IP="13.61.19.221"
FALLBACK_IP="13.60.180.198"  # Blue sunucu IP

# SSH ile reverse proxy üzerindeki nginx config dosyasını geri döndür
ssh -o StrictHostKeyChecking=no -i bl-gr-key.pem ubuntu@$REV_PROXY_IP << EOF
sudo bash -c 'cat > /etc/nginx/sites-available/default << NGINXCONF
server {
    listen 80;
    location / {
        proxy_pass http://$FALLBACK_IP;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
NGINXCONF
sudo systemctl restart nginx
'
EOF
