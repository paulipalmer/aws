#!/bin/bash
# mmarvin 18/02/2019
# This script eases ssh into EC2 instance
# by automating identification and application
# of unique server hostname

key=xxxxxxxxxx.pem
user=xxxxxx #For GEOS tutorial, user=ubuntu
publicDNS=$(aws ec2 describe-instances --query 'Reservations[].Instances[].PublicDnsName' --output text)

ssh -i "$key" ${user}@${publicDNS}
