---
title: Challenge Six
permalink: /docs/challenge6/
---

## Let's add monitoring to our apps.  We want to monitor 4 things


### Monitor the server
  Based on the Ansible scripts from [Challenge 5]({{site.baseurl}}/docs/challenge5), add monitoring of the base server using [site24x7](https://site24x7.com). You may want to start by manually installing it writing down the steps and then create the Ansible script after, or you may want to jump straight to the Ansible based install.
  
### Add site monitoring to the 3 apps we've been installing.

  Play will fail states like stopping the app, stopping the proxy, stopping the mysql database (in the case of the Laravel app).  Does the down trigger hit each time?
  
## Setup Intrusion Detection and Security Scanning

Utilize OSSEC and Linus to set up basic intrusion detection and security scanning.  There are tons of options here, but these two tools are useful out of the box.

You may want to use the Ansible roles found [here](https://galaxy.ansible.com/dj-wasabi/ossec-server) and [here](https://galaxy.ansible.com/tommarshall/lynis)

When you change a core file (like the nginx config) is an alert triggered? By which tool?

How close to green can you get your Lynus setup? (100% is very rare in practice here).


