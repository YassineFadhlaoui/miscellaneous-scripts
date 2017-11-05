#!/bin/bash
#Hello I am yassine, this script aims to connect an isolated LAN to internet through your PC,
#
#Suppose that we have the following architecture :
# _________       ______             _____                   ______
#|internet |-----|router|-----wlan0-|my Pc|-eth0-------ethX-|my LAN|
#


#The first step consist in verifying that Forwarding is supported by the linux kernel
function Enable_IPv4_Forwarding(){
	echo "INFO: Enable IP forwarding in the Linux kernel"
	sudo echo 1 > /proc/sys/net/ipv4/ip_forward
	RES=$(cat /proc/sys/net/ipv4/ip_forward)
	if [ $RES = "0" ]
 	 then
 	   echo "ERROR: you need to recompile the kernel with ip_forward option"
 	   exit 1
        else
  	  echo " INFO : Forwarding is succesfully activated"
	fi
}

function Send_Through_wlan0(){
  echo "INFO:  FORWARDING outgoing connections to external NIC : "
	if  sudo iptables -A FORWARD -i $nic2 -o $nic1 -j ACCEPT
  	then
   	 echo "INFO : FORWARDING rule was added to iptables"
  	else
	 echo "ERROR: can't add FORWARDING rule"
    	 exit 1
	fi
}

function Accept_connections(){
  echo "INFO : FORWARDING incoming connections to internal NIC : "
  if sudo iptables -A FORWARD -i $nic1 -o $nic2 -m state --state ESTABLISHED,RELATED -j ACCEPT
   then
     echo "INFO : FORWARDING rule was added to iptables"
   else
  echo "ERROR: can't add FORWARDING rule"
      exit 1
 fi
}

function Enable_POSTROUTING(){
	echo "--> loading iptables module to kernel"
	sudo modprobe iptable_nat
	echo "--> POSTROUTING and MASQUERADE allows packets to be altered as they are leaving the firewall's external device." | fmt
	if sudo iptables -t nat -A POSTROUTING -o $nic1 -j MASQUERADE
  	then
   	 echo "INFO : POSTROUTING and MASQUERADE are added"
  	else
	 echo "ERROR: can't add POSTROUTING rule"
    	 exit 1
	fi
	}
if [ "$1" == "-h" ]
 then
   cat myLAN.sh | grep \# | awk -F\# '{print $2}'
   exit 0
fi
#we will delete all routes and add them again but with custom metrics to avoid sending packets through default routes
echo -n " --> please type ip address of the gateway to delete : "
read gateway1
echo -n " --> please type the corresponding interface : "
read nic1
sudo route delete default gw $gateway1 $nic1
echo -n " --> please type ip address of the second gateway to delete : "
read gateway2
echo -n " --> please type the corresponding interface : "
read nic2
sudo route delete default gw $gateway2 $nic2
echo "INFO : new routing tabe : "
route -n
# The second step consist in changing route metrics, In fact etherent routes are privileged but this not the case because wlan0 is
# outer interface it should be privileged
echo "--> setting wlan0 related gateway to 0 : "
sudo route add default gw $gateway1 metric 0 $nic1
echo "--> setting eth0 related gateway to 1 : (less privileged) "
sudo route add default gw $gateway2 metric 1 $nic2
#The resulting Routing table shoud look like the following :
#Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
#0.0.0.0         172.31.239.254  0.0.0.0         UG    0      0        0 wlan0
#0.0.0.0         10.0.0.1        0.0.0.0         UG    1      0        0 eth0
#10.0.0.0        0.0.0.0         255.0.0.0       U     1      0        0 eth0
#172.31.238.0    0.0.0.0         255.255.254.0   U     9      0        0 wlan0
echo "--> please test internet connection in your PC and make sure that you can ping to a device located in the isolated LAN "
echo -n "did you finished ? (yes/no)"
read response
case $response in
  *yes|YES|y*)
  #the last step consist in forwarding traffic coming from eth0 (the isolated LAN) to wlan0 :
  # 1. FORWARDING outgoing connections to external NIC
  # 2. FORWARDING incoming connections to internal NIC :
  # 3. adding POSTROUTING and MASQUERADErules to  allow packets to be altered as they are leaving the firewall's external device.
   Enable_IPv4_Forwarding
   Enable_POSTROUTING
   Accept_connections
   Send_Through_wlan0

   echo "these operations are not persistent you have to go through the same steps again after every reboot ";;
   #these operations are not persistent you have to go through the same steps again after every reboot
   ***)
   echo "Oops! it seems that you have problems :("
   exit 0 ;;
 esac