# Linux-to-router
Convert your Linux desktop or server to a router
Linux is a great operating system with its powerful and well-designed kernel. We can use Linux as a router. Actually, It supports the routing function and can be used as a router. This simple script aims to convert a Linux workstation to a router by adding some firewall rules and some tricks.
__________________

## How it works?
Let's assume that we have the following architecture :
```
 _________       ______             _______                   ______
|internet |-----|router|-----wlan0-|your Pc|-eth0-------ethX-|my LAN|
```

We start by deleting all the routes. By default, Linux kernel privileges ethernet interfaces, so it assigns a low metric to the routes reachable from this NIC (Network Card Interface). In our case, this is not functional. Once we plug the ethernet cable to link our pc and our LAN we should notice that the internet connection is lost but why?

Let's unplug the ethernet cable and reconnect using wifi. Now let's issue the following command:
```
route -n
```
we should notice the following:
```
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.100.1   0.0.0.0         UG    0      0        0 wlan0
192.168.100.0   0.0.0.0         255.255.255.0   U     9      0        0 wlan0
```

The first line where the destination is 0.0.0.0 and the NIC is wlan0 is called default route. Actually, the packets destinated to Facebook servers and google servers passe through this interface. We clearly notice that the metric assigned to this default route is 0. 

### Note:
The lower the metric the better the route

Now let's plug the ethernet cable again (linking our PC with an other PC). we issue the following command:
```
route -n
```
here is the result :
```
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.0.1        0.0.0.0         UG    0      0        0 eth0
10.0.0.0        0.0.0.0         255.0.0.0       U     1      0        0 eth0
192.168.100.0   0.0.0.0         255.255.255.0   U     9      0        0 wlan0
```
terrible isn't it ?

the metric assigned to the wireless route is 9 and the metric assigned to the ethernet route is 0. So, the packets destinated to facebook and google will not be sent to your access point anymore. In contrast, they will be sent through the ethernet interface to a regular PC (which will drop them instantly) that's why you lost your internet connection.

* The first step is tune these metrics. We will choose a lower metric for wlan0 NIC and a high metric for the ethernet interface. 

* The second step is to active forwarading and NAT in our PC 
_______________________
# Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 
```
$ git clone https://github.com/YassineFadhlaoui/Linux-to-router
$ cd Linux-to-router
```
_____________________

## Used programming languages
  
  * bash

## Authors

* **Yassine Fadhlaoui** - *Initial work* - [Yassine Fadhlaoui](https://github.com/YassineFadhlaoui)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/YassineFadhlaoui/Linux-to-router/blob/master/LICENSE) file for details
