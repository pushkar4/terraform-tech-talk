#!/bin/bash

user_id=$(whoami)
stack_name="$user_id-van-rds-dont-keep"
action=$1

if [ "$action" == "deploy" ]; then

  cmd="aws cloudformation deploy --template-file ./rds-stack.yaml --stack-name $stack_name \
  --parameter-overrides DBInstanceIdentifier=$user_id-van-db-dont-keep --tags DeployedBy=$user_id"
  echo "Running deploy with command:"
  echo "$cmd"
  eval "$cmd"
  echo "DO NOT FORGET TO DELETE YOUR STACK AFTER TESTING: ./manage_rds_stack.sh remove"

elif [ "$action" == "remove" ]; then

  cmd="aws cloudformation delete-stack --stack-name $stack_name"
  echo "Running remove with command:"
  echo "$cmd"
  eval "$cmd"

else

  echo " manage_rds_stack.sh [deploy|remove]"
  echo "   deploy - Deploy the cloudformation RDS stack"
  echo "   remove - Remove the cloudformation RDS stack"
  echo " WARNING: Remember to delete your stack post testing."

fi
