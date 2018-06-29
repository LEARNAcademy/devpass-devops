---
title: Challenge Two
permalink: /challenge2
---

## Serving a static site

### Recreate a the nginx server from Challenge 1

[Challenge One](./challenge1)


Never by afraid to go back an review lessons or use the tutorial as a cheat sheet. 

> it is often helpful to create your own cheatsheets for thinsg like setting up a basic Ubuntu instance

### Download this code and copy it up to your site

[httpstatuscat](https://github.com/6IX7ine/httpstatuscat)

- What commands do you use to get a git repository?
- What commands do you use to copy files up to a server?
- What location do the files need to live in to show on the web?


## Serving a Web App

We are going to server a web app. We want to break that down in to a couple steps.  The first step is getting the app running on the server. Then we'll figure out how to proxy it via our Nginx configuration.

### Install Needed Packages

`sudo apt update && sudo apt install git nodejs npm`

### Clone The App

```bash
sudo su -  # become root
cd /var/www/html
git clone https://github.com/LEARNAcademy/http-status-cats-api.git webapp
```

### Install App Dependencies

```bash
sudo su -
cd /var/www/html/webapp

```

### Start The App

```bash
PORT=4000 nodejs index.js
```
### Test It Out

Open http://IP OF YOU INSTANCE:4000 and see if the site loads

![See The app](img/seeapp.png)

### Add the Proxy Configuration

So that our app keeps running for the moment, we're going to stop the app by typing "CTRL-c". CTRL-c is the common keyboard short cut to terminate a running program. Once that is done, press the up arrow on your keyboard to bring back the last command and add an '&' to the end of it then hit enter again.  Now the node app is running in the background.

```bash
PORT=4000 nodejs index.js
```

We are going to edit /etc/nginx/sites-enabled/default to add our proxy config

```nginx
# This goes above server {
upstream cats {
        server 127.0.0.1:4000;
        server localhost down;
}

# This part goes after the } on location / {
location /cats/ {
        proxy_pass http://cats/;
}
```

This passes all traffic from our ip on port 80 with the subdirectory /cats to the running node application.

### Restart Nginx

sudo /etc/init.d/nginx restart

### Check for the App On Port 80 

Open http://IP OF YOUR INSTANCE/cats and see if your app shows up.  Does / still show your static site version?

## Clean Up

Do not forget to shut down your ec2 instance (terminate it!) once you are done for the night. The instance is charge by the minute, so leaving it running when you do not want to is just as bad as leaving the kitchen faucit on. You are pouring money down the drain.

### Find the Instance in the Web Console

### Right Click and Select Terminate

Do not forget to confirm the warning dialog
 
