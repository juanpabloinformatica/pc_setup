# Description


- Steps to instal archlinux

- Get the correct ISO in a boot media
- Set the console keyboard, in my case us 
  default works fine. -> (loadkeys <keyboard_layout>)
- Verify the boot mode either BIOS | EFI
  if # cat /sys/firmware/efi/fw_platform_size
    -> == 64 -> system is booted in UEFI mode and has a 64-bit x 64
    -> == 32 -> system is booted in UEFI mode and has a 32-bit x 32
    -> system is booted with BIOS

- Connect to internet -> arch run system has enabled some crucial programs
  for allowing the connection to the internet for wlan recommended using
  iwctl
  - make sure the card is not blocked rfkill
  - ethernet works by default
  - Check up internet interfaces with ip link

- Update the systemclock ---> ATTENTION IF U ARE CONNECTED TO VPN
  - Normally is done automatically by systemd-timesyncd 
    daemon process --> daemon process is a process
    that runs in the background
  - to check if is synchronized check timedatectl

- For partitioning the disk
  - KEEP IN MIND THAT ----> **/dev/sda could be different in your case**
  - check disk with fdisk or lsblk
  - It depends the layout in my case
  - I take one partition to the boot --> /boot -> min req =~ +512M => type efi system (fat -F 32)
  - Other partition to the root  --> / --> resting portion -> type linux system (ext4)
  - Other partition not done manually, but done by 
    zram

- For formatting the partitions
  - it depends what filesystem u want to use in this case 
  - the /boot partition --> is formatted with fat.32 
  ```
  mkfs.fat -F 32 /dev/sda1
  ```
  - The / partition --> is formatted with the filesystem fat.ext4
  ```
  mkfs.ext4 /dev/sda2
  ```
- Packages
  - pacstrap -K leet install that in the root that our system 
    after rebooting will be.
  - pacstrap -K /mnt base linux linux-firmware
  - arch-chroot /mnt -> change to the root of our future system
  - and the install there, here you need to check spec of your system.
    - pacman -Syu intel-ucode linux-firmware iwd ipala vim man-db man-pages texinfo
    - for network manager i will keep going with iwd i  like it 

- Generate Fstab
  - To always at booting set up partitions
    ```
     genfstab -U /mnt >> /mnt/etc/fstab
    ```
- Time
  - Set the time zone
    - a symlink (-s) is created with the overwrite option (-f)
    - In my case the Regios=Europe city=Paris
    ```
      # ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
        timedatectl set-timezone Europe/Paris
        hwclock --systohc
    ```
    - Check ntp for network sync

- Localization
  -  so generate locale file for config by doing locale-gen
  - then edit the created file uncommenting the right locales
    in this case line en_US.UTF-8 UTF-8 (file="/etc/local.conf")
  - set the keyboard is modified, in my case I kept the same 'us'
    (file to edit "/etc/vconsole.conf")

- Network configuration

  - modified the file "/etc/hostname"

- Boot loader
  - Foor booting the system there are different options
    depending of the firmware ur hardware has BIOS or EFI
    I will go systemd.boot that is available for EFI systems
    ```
      bootctl install
    ```







 


    





  

# Remarks

- KEEP IN MIND VPN, CAN AFFECT IN TIME SYNC !!

# What to recheck
  - LVM | RAID
