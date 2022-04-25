#!/bin/bash
#Setting up User doe RDP....
echo "Setting up password for nor-root user ${USER} ..."
sudo passwd ${USER}
#
echo "XRDP Password set for User ${USER}"
