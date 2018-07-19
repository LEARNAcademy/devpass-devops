---
title: Challenge Two
permalink: /docs/challenge2/
---

## Serving a static site

### Recreate a the nginx server from Challenge 1

[Challenge One]({{site.baseurl}}/docs/challenge1)

Never by afraid to go back an review lessons or use the tutorial as a cheat sheet. 

> it is often helpful to create your own cheatsheets for thinsg like setting up a basic Ubuntu instance

### Download this code to your local machine and copy it up to your site

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
npm install
```

### Start The App

```bash
PORT=4000 nodejs index.js
```
### Test It Out

Open http://IP OF YOU INSTANCE:4000 and see if the site loads

![See The app]({{site.baseurl}}/img/seeapp.png)

> If your browser just spins for a long time before timing out, then you do not have the AWS Security Group set correctly to allow port 4000. Log in to the AWS console to fix.

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

### Install a Rails application

Follow the same procedure to get this Rails application running on port 3000. 

> If your browser just spins for a long time before timing out, then you do not have the AWS Security Group set correctly to allow port 3000. Log in to the AWS console to fix.

Install RVM using these [instructions](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rvm-on-ubuntu-16-04)

```bash
sudo apt install libpq-dev  # need this for the bundle
##### make sure you are not root for these next steps
rvm install 2.4.1
git clone https://github.com/RailsApps/learn-rails.git
cd learn-rails
bundle
rails s -b 0.0.0.0
```

### Install a Laravel app

Before you start

> Log in to the AWS console to fix the security group to allow port 8000.

```bash
apt install composer php7.0-mbstring php7.0-dom zip unzip mysql-client mysql-server php7.0-mysql
```

Before running the migration 

- change "127.0.0.1" to "localhost" in the .env file, 
- change the mysql user to root and the password to blank (assuming you left it blank during install above)
- on the command line run "sudo mysqladmin create homestead"

On the last step below you need to change "php artisan serve" to "php artisan serve --host 0.0.0.0"

Otherwise follow the instructions [here](https://github.com/laravel/quickstart-basic)

### Init System

Create init scripts for your 3 services to start them when the system restarts. Here is an example file for the node app.  They live in /etc/systemd/system. Let's call this first one /etc/systemd/system/node_cats.service

> Multiple lines in this file need to change for each service ;-)

```systemd
[Unit]
Description=Node Cat Server
Requires=network.target

[Service]
Type=simple
User=root
Group=root
WorkingDirectory=/var/www/html/webapp
ExecStart=/bin/bash -lc 'PORT=4000 nodejs index.js'
TimeoutSec=30
RestartSec=15s
Restart=always

[Install]
WantedBy=multi-user.target
```
> Use `sudo systemctl daemon-reload` after you add new scripts

> Use `sudo systemctl start node_cats` to launch

> Use `sudo systemctl enable node_cats` to launch on reboot

> Use `sudo systemctl status node_cats` to see the status

Some hints - for Rails, you need "RAILS_RELATIVE_URL_ROOT=/rails /home/ubuntu/.rvm/wrappers/ruby-2.4.1/rails" instead of just the "rails" command. The relative root is for making the app routes match your nginx config subdirectory

Both it and the Laravel app you should run them as the ubuntu user and group

### Verify reboot

There are two ways to reboot the server. Either type `sudo shutdown -r now` in the terminal or go to the AWS console, right click on the ec2 container, select instance state and select restart.

After the system comes back up is everything still running?

## Clean Up

Do not forget to shut down your ec2 instance (terminate it!) once you are done for the night. The instance is charge by the minute, so leaving it running when you do not want to is just as bad as leaving the kitchen faucit on. You are pouring money down the drain.

### Find the Instance in the Web Console

![Find Instance]({{site.baseurl}}/img/findinstance.png)

### Right Click and Select "Instance State" > "Terminate"

![Termiante]({{site.baseurl}}/img/terminate.png)
Do not forget to confirm the warning dialog
