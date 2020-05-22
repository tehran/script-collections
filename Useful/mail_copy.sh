#!/bin/bash
day=$(date +"%d_%m_%Y")
min=$(date +"%H:%M")
cd /home1/vsllccom/mailbackup
mkdir -p $day/$min &&
cp -R /home1/vsllccom/mail/vsllc.com/* /home1/vsllccom/mailbackup/$day/$min