#!/bin/bash
# Check if the crontab entry already exists
if crontab -l | grep -q 'atm10.riipeckx.io.service'; then
    echo "Crontab entry already exists."
else
    # Add the crontab entry to restart the service daily at 3:59am
    (crontab -l 2>/dev/null; echo "59 3 * * * /usr/bin/systemctl restart atm10.riipeckx.io.service") | crontab -
    echo "Crontab entry added to restart atm10.riipeckx.io.service daily at 3:59am."
fi
