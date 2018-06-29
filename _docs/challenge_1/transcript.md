# Challenge One
## Get a server started with ssh access, copy (no copy and paste) a hello world file up to it.

# Steps To Complete

## Launch an Instance 

### Log in To AWS

### Set Region to Oregon

### Click EC2

### Click Running Instances

### Click 'Launch Instance'

### Scroll to Ubuntu Server 16.04 LTS

### Select t2.micro size

### Launch 1 instance, leave everything else as defaults

### Leave Storage As Defaults

### Leave Tags As Defaults

### In Security Groups Set HTTP to Anywhere

### Click Review and Launch

Will give you a security warning because port 80 is open to the world, this is as planned.

### Click Launch and Create New Keypair

### Copy the Key in To .ssh

### Chmod 600 .ssh/devpass

### Wait for Instance To Spin Update

## Start Nginx

### SSH in to Instance

In terminal

`ssh -i ~/.ssh/devpass ubuntu@IP_ADDRESS`

### Install Nginx

`apt update && apt install nginx`

### Start Nginx

`/etc/init.d/nginx start`

## Upload your own file

### Create an HTML File

### Upload the Index.html File via SCP

### Move File To Correct Config Location

`mv index.html /var/www/html/index.html`


### Refresh the Page
