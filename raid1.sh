
lsblk
sudo apt install mdadm -y
sudo mdadm --create --verbose /dev/md5 --level=1 --raid-devices=2 /dev/nvme1n1 /dev/nvme2n1
````

#### Création du système de fichier .ext4 dans le volume logique md5

````bash
sudo mkfs.ext4 -F /dev/md5
````

#### Monter le système de fichier

````bash
sudo mount /dev/md5 /mnt
````

#### Attribution des droits dans le dossier /mnt

````bash
sudo chmod o+w /mnt
````

#### Vérifier l'espace du disque (Optionnel)

````bash
sudo df -hT
````

## Sauvegarder la pertinence du raid



#### Cette commande scan et ajoute le log dans le fichier  le volume logique automatiquement à chaque boot

````bash
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
````

#### Mettre a jour l'initramfs afin de garder la configuration du RAID après un reboot

````bash
sudo update-initramfs -u
````

#### Ajoute le système de fichier monté dans le fichier /etc/fstab pour un montage automatique lors du boot.

````bash
echo '/dev/md5 /mnt/md5 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab
````

#### Redémarre la machine linux

````bash
sudo reboot
````

#### Vérification de l'état du RAID 1

```
sudo cat /proc/mdstat
```

