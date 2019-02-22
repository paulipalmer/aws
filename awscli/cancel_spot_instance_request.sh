#!/bin/bash
# mmarvin 18/02/2019
# This script cancels spot request
# using unique spot instance ID

spotinstanceID=$(aws ec2 describe-instances --query 'Reservations[].Instances[].SpotInstanceRequestId' --output text)

aws ec2 cancel-spot-instance-requests --spot-instance-request-ids $spotinstanceID
