#!/bin/bash
# From: https://cloud-gc.readthedocs.io/en/latest/chapter03_advanced-tutorial/advanced-awscli.html

# == often change ==
TYPE=r4.large   # EC2 instance type

# ==  set it once and seldom change ==
AMI=ami-06f4d4afd350f6e4c   # AMI to launch from
SG=sg-xxxxxxxxxxxxxxxxx     # security group ID
KEY=xxxxxxxxxxxxxxxxx       # EC2 key pair name
COUNT=1                     # how many instances to launch
IAM=xxxxxxxxx               # EC2 IAM role name
# EBS_SIZE=200                # root EBS volume size (GB)

# == almost never change; just leave it as-is ==
aws ec2 run-instances --image-id $AMI \
    --security-group-ids $SG --count $COUNT \
    --instance-type $TYPE --key-name $KEY \
    --iam-instance-profile Name=$IAM
#    --block-device-mappings DeviceName=/dev/sda1,Ebs={VolumeSize=$EBS_SIZE}
