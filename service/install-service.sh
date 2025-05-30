#!/usr/bin/env sh
SERVICE_NAME="atm10.riipeckx.io"
echo 'Installing service now...'
cp -rp $SERVICE_NAME /etc/systemd/system/$SERVICE_NAME.service
echo 'Service installed successfully!'
