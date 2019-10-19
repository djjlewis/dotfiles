sudo ln -sf /usr/lib/systemd/scripts /etc/init.d
export $def_sysconfdir=/etc/init.d
sudo pacman -S base-devel python2 linux-headers --noconfirm
ln -sf /usr/bin/python2 /usr/local/bin/python

sudo mkdir /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom
cd /mnt/cdrom
sudo ./install

sudo echo "[Unit]
Description=Parallels Tools
[Service]
Type=oneshot
ExecStart=/usr/lib/systemd/scripts/prltoolsd start
ExecStop=/usr/lib/systemd/scripts/prltoolsd stop
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target" > /usr/lib/systemd/system/parallels-tools.service

sudo rm /usr/local/bin/python
