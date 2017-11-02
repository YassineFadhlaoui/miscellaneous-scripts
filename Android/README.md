## Android files Uploader

Unfortunately, there is no accurate and sophisticated software for Linux that allows reading and writing Android File System.
I chose to use HTTP  to address this problem.

### Overview

Instead of installing tonnes of software and adding repositories to your Linux
I developed a short nodeJS script that allows us to upload files from Android devices.

* Install nodejs
* Clone this project and get into it
* npm install to install dependencies
* then start the server by running node Uploader.js
* from your Android device visit the link provided below:
http://YOUR_IP_ADDRESS:3000
* A simple web interface will appear. browse your device and choose the file you want to upload
* Then Submit
* You might be connected through LAN or WLAN then upload speed varies depends on your equipment but still acceptable (22MB/s in my case)



