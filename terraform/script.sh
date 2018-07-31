#! /bin/bash

echo `hostname -I` `hostname` | sudo tee -a /etc/hosts 
sudo apt-get install libcurl4-gnutls-dev
sudo apt-get update
sudo apt-get install -y collectd
