#!/bin/bash

param=$1
response=""

case $param in

  current_date)
    response=$(date -u '+%Y-%m-%dT%H:%M:%S')
    ;;

  user_id)
    response=$(whoami)
    ;;

esac

# Terraform expects the result in json format
echo "{\"response\":\"${response}\"}"
