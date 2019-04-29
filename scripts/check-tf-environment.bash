#!/usr/bin/env bash

################################
# CHECK ENV VARS

VARNAMES=(
    "AWS_ACCESS_KEY_ID"
    "AWS_SECRET_ACCESS_KEY"
    "EKS_CLUSTER_NAME"
    "TERRAFORM_ADMIN_ROLE_ARN"
)

VARVALS=(
    "$AWS_ACCESS_KEY_ID"
    "$AWS_SECRET_ACCESS_KEY"
    "$EKS_CLUSTER_NAME"
    "$TERRAFORM_ADMIN_ROLE_ARN"
)

len=${#VARNAMES[@]}

for (( i=0; i<len; i++ )) ; do
     if [ -z "${VARVALS[$i]}" ] ; then
         echo "Environment variable '${VARNAMES[$i]}' is not set."
         exit 1
     fi
done
