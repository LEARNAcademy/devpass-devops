---
title: Challenge Five
permalink: /docs/challenge5/
---

## Use the Ansible scripts found [in challenge 4 here](https://github.com/LEARNAcademy/devpass-devops/tree/master/files/challenge4) to recreate your server with all 3 apps running. 

This challenge builds off the work from the challenges so far. 

1. Install Ansible via these instructions for [your machine](https://docs.Ansible.com/ansible/latest/installation_guide/intro_installation.html)
1. Clone the devpass repo on your local machine via git
1. Change directory in to the repo, change in to [files/challenge4](https://github.com/LEARNAcademy/devpass-devops/tree/master/files/challenge4)
1. `cp ec2.ini.sample ec2.ini` 
1. Edit ec2.ini to include your AWS key and secret at the very bottom of the file
1. Create a directory called `.aws` in your home folder if it does not exist `mkdir ~/.aws`
1. Copy the sample credential file to `~/.aws/credentials`
1. Edit the `~/.aws/credentials` file and add your AWS keypair there as well
1. Add your devpass ssh key to the list of keys ssh will try automatically via `ssh-add ~/.ssh/devpass_rsa`
1. Run `ansible-playbook -i ec2.py launch.yml

Notice how the process launches an EC2 image, and then configures that image. If you have to reconfigure after making changes (like to complete the next two exercises) you can safely run the Ansible command again, or cut out the launch.yml and only run configure.yml (launch __includes_ configure) by running `ansible-playbook -i ec2.py configure.yml`

## Add your backup script to the Ansible recipe and install it on your server via Ansible. 

> Use the steps from the last challenge as a template to what you need to install.

## Set up Papertail via Ansible instead of manually installing it.

Hint: When debugging an Ansible role, comment out all the steps before your got stuck, to keep from having to go over them again

Questions

1) How many Ansible _commands_ are used in these Ansible scripts?

2) How much of the local config files (see devpass-devops/files/challenge4/files) match the ones you've been creating?

3) How would we spin up more than one copy of this?

## Either tear down manually or use the script located in `ansible-playbook -i ec2.py cleanup.yml` when you are done
