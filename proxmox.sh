#!/bin/bash
cat ./ProxmoxInterfaces.txt >> /etc/network/interfaces;
systemctl restart networking;
apt-get install python3-pip python3-venv -y;
python3 -m venv myenv;
source myenv/bin/activate;
pip3 install wldhx.yadisk-direct;
read -p "Введите имя вашего локального хранилища: " STORAGE

# ISP ----------------------------
curl -L $( exit ) -o ISP-disk001.vmdk
qm create 200 --name "ISP" --cores 1 --memory 1024 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr0 --net1 virtio,bridge=vmbr20 --net2 virtio,bridge=vmbr21 --net3 virtio,bridge=vmbr22
qm importdisk 200 ISP-disk001.vmdk $STORAGE --format qcow2 
qm set 200 -ide0 $STORAGE:vm-200-disk-0 --boot order=ide0
echo "ISP is done!!!"


# RTR ----------------------------
curl -L $(yadisk-direct https://disk.yandex.ru/d/RTO6rzQCgoi_2w) -o HQ-RTR-disk001.vmdk
qm create 201 --name "HQ-RTR" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single --net0 e1000,bridge=vmbr20 --net1 e1000,bridge=vmbr23 
qm importdisk 201 HQ-RTR-disk001.vmdk $STORAGE --format qcow2 
qm set 201 -ide0 $STORAGE:vm-201-disk-0 --boot order=ide0
echo "HQ-RTR is done!!!"

curl -L $(yadisk-direct https://disk.yandex.ru/d/RTO6rzQCgoi_2w) -o BR-RTR-disk001.vmdk
qm create 202 --name "BR-RTR" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single --net0 e1000,bridge=vmbr21 --net1 e1000,bridge=vmbr24
qm importdisk 202 BR-RTR-disk001.vmdk $STORAGE --format qcow2 
qm set 202 -ide0 $STORAGE:vm-202-disk-0 --boot order=ide0
echo "BR-RTR is done!!!"

curl -L $(yadisk-direct https://disk.yandex.ru/d/RTO6rzQCgoi_2w) -o DC-RTR-disk001.vmdk
qm create 203 --name "DC-RTR" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single --net0 e1000,bridge=vmbr22 --net1 e1000,bridge=vmbr25
qm importdisk 203 DC-RTR-disk001.vmdk $STORAGE --format qcow2 
qm set 203 -ide0 $STORAGE:vm-203-disk-0 --boot order=ide0
echo "DC-RTR is done!!!"

# SW ----------------------------
curl -L $(yadisk-direct https://disk.yandex.ru/d/eeydoZIZbWG9Iw) -o HQ-SW1-disk001.vmdk
qm create 204 --name "HQ-SW1" --cores 1 --memory 1024 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr23 --net1 virtio,bridge=vmbr28 --net2 virtio,bridge=vmbr29 --net3 virtio,bridge=vmbr30
qm importdisk 204 HQ-SW1-disk001.vmdk $STORAGE --format qcow2
qm set 204 -ide0 $STORAGE:vm-204-disk-0 --boot order=ide0
echo "HQ-SW1 is done!!!"

curl -L $(yadisk-direct https://disk.yandex.ru/d/eeydoZIZbWG9Iw) -o BR-SW1-disk001.vmdk
qm create 205 --name "BR-SW1" --cores 1 --memory 1024 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr24 --net1 virtio,bridge=vmbr31 --net2 virtio,bridge=vmbr26 --net3 virtio,bridge=vmbr27
qm importdisk 205 BR-SW1-disk001.vmdk $STORAGE --format qcow2
qm set 205 -ide0 $STORAGE:vm-205-disk-0 --boot order=ide0
echo "BR-SW1 is done!!!"

curl -L $(yadisk-direct https://disk.yandex.ru/d/eeydoZIZbWG9Iw) -o BR-SW2-disk001.vmdk
qm create 206 --name "BR-SWSW22" --cores 1 --memory 1024 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr26 --net1 virtio,bridge=vmbr27 --net2 virtio,bridge=vmbr32
qm importdisk 206 BR-SW1-disk001.vmdk $STORAGE --format qcow2
qm set 206 -ide0 $STORAGE:vm-206-disk-0 --boot order=ide0
echo "BR-SW2 is done!!!"

curl -L $(yadisk-direct https://disk.yandex.ru/d/eeydoZIZbWG9Iw) -o DC-SW1-disk001.vmdk
qm create 207 --name "DC-SW1" --cores 1 --memory 1024 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr25 --net1 virtio,bridge=vmbr28 --net2 virtio,bridge=vmbr33 --net3 virtio,bridge=vmbr34
qm importdisk 207 DC-SW1-disk001.vmdk $STORAGE --format qcow2
qm set 207 -ide0 $STORAGE:vm-207-disk-0 --boot order=ide0
echo "DC-SW1 is done!!!"

# SERVERS ----------------------------
curl -L $(yadisk-direct https://disk.yandex.ru/d/eeydoZIZbWG9Iw) -o HQ-SRV1-disk001.vmdk
qm create 208 --name "HQ-SRV1" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr28
qm importdisk 208 HQ-SRV1-disk001.vmdk $STORAGE --format qcow2
qm set 208 -ide0 $STORAGE:vm-208-disk-0 --boot order=ide0
echo "HQ-SRV1 is done!!!"

curl -L $(yadisk-direct https://disk.yandex.ru/d/eeydoZIZbWG9Iw) -o HQ-SRV2-disk001.vmdk
qm create 209 --name "HQ-SRV2" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr29
qm importdisk 209 HQ-SRV2-disk001.vmdk $STORAGE --format qcow2
qm set 209 -ide0 $STORAGE:vm-209-disk-0 --boot order=ide0
echo "HQ-SRV2 is done!!!"

curl -L $(yadisk-direct https://disk.yandex.ru/d/eeydoZIZbWG9Iw) -o BR-SRV-disk001.vmdk
qm create 210 --name "BR-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr31
qm importdisk 210 BR-SRV-disk001.vmdk $STORAGE --format qcow2
qm set 210 -ide0 $STORAGE:vm-210-disk-0 --boot order=ide0
echo "BR-SRV is done!!!"

curl -L $( exit ) -o DC-SRV1-disk001.vmdk
qm create 211 --name "DC-SRV1" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr33
qm importdisk 211 DC-SRV1-disk001.vmdk $STORAGE --format qcow2
qm set 211 -ide0 $STORAGE:vm-211-disk-0 --boot order=ide0
echo "DC-SRV1 is done!!!"

curl -L $( exit ) -o DC-SRV2-disk001.vmdk
qm create 212 --name "DC-SRV2" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr34
qm importdisk 212 DC-SRV2-disk001.vmdk $STORAGE --format qcow2
qm set 212 -ide0 $STORAGE:vm-212-disk-0 --boot order=ide0
echo "DC-SRV2 is done!!!"

# CLIENTS ----------------------------
curl -L $(yadisk-direct https://disk.yandex.ru/d/Vf9gwcrzDPE1FQ) -o HQ-CLI-disk001.vmdk
qm create 213 --name "HQ-CLI" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single --net0 virtio,bridge=vmbr30 
qm importdisk 213 HQ-CLI-disk001.vmdk $STORAGE --format qcow2 
qm set 213 -ide0 $STORAGE:vm-213-disk-0 --boot order=ide0
echo "HQ-CLI is done!!!"

curl -L $(yadisk-direct https://disk.yandex.ru/d/DetNZ_gicbh-Kg) -o BR-CLI-disk001.vmdk
qm create 214 --name "BR-CLI" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr32 
qm importdisk 214 BR-CLI-disk001.vmdk $STORAGE --format qcow2 
qm set 214 -ide0 $STORAGE:vm-214-disk-0 --boot order=ide0
echo "BR-CLI is done!!!"

echo "ALL DONE!!!"
