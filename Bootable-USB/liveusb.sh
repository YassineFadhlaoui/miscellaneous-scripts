dialog --title "Live USB" --msgbox "Live USB creator By YASSINE" 10 50
dialog --title "Choose an USB" --inputbox "Please enter a valid USB partition : (example /dev/sdb1) $(lsblk)" 20 50 2> ./.tempfile
selected=$(cat ./.tempfile)
if test -z $selected
  then
    dialog --title "Choose an USB" --inputbox "Please enter a valid USB partition : (example /dev/sdb1) $(lsblk)" 20 50 2> ./.tempfile
  else
    if echo $selected | grep sda
      then
        dialog --title "Not Permitted" --msgbox "Operation not Permitted the selected disk is your hard drive disk" 10 50
      else
        dialog --title "Live USB" --yesno "A bootable usb will be created :\n Source      :$1 \n Destination : $selected \n Block Size  : 4M \n Would you like to continue?" 10 50
        sudo umount $selected
        sudo dd bs=4M if=$1 of=$partition
  fi
fi
