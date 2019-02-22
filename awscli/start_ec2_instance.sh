#!/bin/bash
# mmarvin 18/02/2019
# This script starts EC2 instance
# using unique instance ID

instanceID=$(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --output text)

aws ec2 start-instances --instance-ids $instanceID
