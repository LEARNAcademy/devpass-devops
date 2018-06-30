---
title: Challenge One
permalink: /docs/challenge1/
---

## Your Mission

Get a server started with ssh access, copy (no copy and paste) a hello world file up to it.

# Steps To Complete

<video src="https://d3vv6lp55qjaqc.cloudfront.net/items/3K1x410a1q3M2E2G0R1I/Screen%20Recording%202018-06-01%20at%2014.46.mov" controls style="display: block;height: auto;width: 100%;">Screen Recording 2018-06-01 at 14.46.mov</video>

## Launch an Instance 

Our goal in this first part is to get a server instance (a virtual server on Amazon's server stack) up and running. We'll do most of the work for this in the AWS web console in our browser.

### Log in To AWS

Go to https://aws.amazon.com to start. Click on the "Sign in to the Console" button.
![Signin]({{site.baseurl}}/img/signin.png)

### Set Region to Oregon

![Region]({{site.baseurl}}/img/setregion.png)

The region is which AWS data center around the world we are going to work in.  We choose us-west-2 for now, as it is close to us geographically while still being a very new data center.  us-west-1 (N. California) does not support all of AWS's most curent features as it is an older data center in need of some upgrades. Theorically all the data centers would opperate basically the same, but since they contain slightly different hardware there are sometimes different supported services and different costs per service. 

### Click EC2

![Click EC2]({{site.baseurl}}/img/clickec2.png)

### Click Running Instances

![Click Running Instances]({{site.baseurl}}/img/runninginstances.png)

### Click 'Launch Instance'

![Launch Instances]({{site.baseurl}}/img/launchinstance.png)

### Scroll to Ubuntu Server 16.04 LTS

![Select Ubuntu]({{site.baseurl}}/img/ubunutimage.png)

### Select t2.micro size

As you can see there are a lot of size options available. Different needs call for different sizes, but for the most part you'll want either T instances (for small tasks) or M instances which balance which balance resources fairly evenly.

### Launch 1 instance, leave everything else as defaults

### Leave Storage As Defaults

### Leave Tags As Defaults

### In Security Groups Set HTTP to Anywhere and Port 4000 to Anywhere

We want to be able to access port 80 (HTTP) for now, but when we do an application later, it will help to have port 4000 open.

### Click Review and Launch

![AWS Launch]({{site.baseurl}}/img/awslaunch.gif)

Will give you a security warning because port 80 is open to the world, this is as planned.

### Click Launch and Create New Keypair

![AWS Keypair]({{site.baseurl}}/img/keypair.png)

### Copy the Key in To .ssh

`cp PATHOFKEY ~/.ssh/devpass_rsa`

### Chmod 600 .ssh/devpass_rsa

We need to lock the permissions down on the file, or SSH won't let us use it.  600 means this user can read and write the key, but no one else can

`chmod 600 ~/.ssh/devpass_rsa`

### Wait for Instance To Spin Update

![Pending AWS]({{site.baseurl}}/img/pendingaws.png)

You may have to click refresh a few times before the **Instance State** goes to _running_

## Start Nginx

In this section we will install Nginx on the instance and start it running

### SSH in to Instance

In terminal

`ssh -i ~/.ssh/devpass_rsa ubuntu@IP_ADDRESS`

### Install Nginx

`sudo apt update && sudo apt install nginx`

### Start Nginx

`sudo /etc/init.d/nginx start`

## Upload your own file

You can copy files from one machine to another over ssh, using a tool called **scp**

### Create an HTML File

![HTML File in Atom]({{site.baseurl}}/img/htmlfile.png)

```html
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Hello World</title>
  </head>
  <body>
    <h1>YO</h1>
  </body>
</html>
```

### Upload the index.html File via SCP

`scp -i ~/.ssh/devpass_rsa index.html YOUR IP:./index.html`

### Move File To Correct Config Location


``` bash
ssh -i ~/.ssh/devpass_rsa ubuntu@IP_ADDRESS
sudo mv index.html /var/www/html/index.html
```

### Refresh the Page In Your 

You should now see the page saying "YO" in your browser!

## Clean Up

Do not forget to shut down your EC2 instance (terminate it!) once you are done for the night. The instance is charge by the minute, so leaving it running when you do not want to is just as bad as leaving the kitchen faucit on. You are pouring money down the drain.

### Find the Instance in the Web Console

![Find Instance]({{site.baseurl}}/img/findinstance.png)

### Right Click and Select "Instance State" > "Terminate"

![Termiante]({{site.baseurl}}/img/terminate.png)
Do not forget to confirm the warning dialog
