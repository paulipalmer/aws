#!/bin/bash
# mmarvin 18/02/2019
# This script stops EC2 instance
# using unique instance ID

instanceID=$(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --output text)

aws ec2 stop-instances --instance-ids $instanceID
