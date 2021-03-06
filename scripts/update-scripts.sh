#!/bin/bash
# Just make sure that we're running on-rpi-boot.sh on every boot
if [ "$(grep -c on-rpi-boot.sh /etc/rc.local)" != "1" ]
then
  echo "/root/scripts/on-rpi-boot.sh" >> /etc/rc.local
  /root/scripts/on-rpi-boot.sh
fi

grep -v "exit 0" /etc/rc.local > /etc/rc.local-new
echo "exit 0" >> /etc/rc.local-new
mv /etc/rc.local-new /etc/rc.local
chmod u+x /etc/rc.local

cd /root
if [ -d /root/dfri-rpi-tor ]
then
  mv dfri-rpi-tor dfri-rpi-tor-saved
fi
git clone https://github.com/DFRI/dfri-rpi-tor.git
if [ $? -eq 0 ]
then
  rm -rf dfri-rpi-tor-saved
else
  mv dfri-rpi-tor-saved dfri-rpi-tor
fi
ln -sf /root/dfri-rpi-tor/scripts /root/scripts
