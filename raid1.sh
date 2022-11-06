lsblk
sudo apt install mdadm -y
sudo mdadm --create --verbose /dev/md5 --level=1 --raid-devices=2 /dev/nvme1n1 /dev/nvme2n1 -f -y
sudo mkfs.ext4 -F /dev/md5
sudo mount /dev/md5 /mnt
sudo chmod o+w /mnt
sudo df -hT
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo update-initramfs -u
echo '/dev/md5 /mnt/md5 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab
sudo cat /proc/mdstat
