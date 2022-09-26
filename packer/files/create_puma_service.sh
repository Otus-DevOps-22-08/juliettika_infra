#!/bin/bash
echo "Creating puma service"

cat > /etc/systemd/system/puma.service << EOF
[Unit]
  Description=puma service
[Service]
  WorkingDirectory=/home/ubuntu/reddit
  Type=simple
  ExecStart=/usr/local/bin/puma
  Restart=always
[Install]
  WantedBy=multi-user.target
EOF
chmod 777 /etc/systemd/system/puma.service
systemctl daemon-reload
systemctl start puma
systemctl enable puma
