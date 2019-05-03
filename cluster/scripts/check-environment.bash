#!/usr/bin/env bash

################################
# CHECK ENV VARS

VARNAMES=(
    "EKS_CLUSTER_NAME"
    "REMOTE_STATE_BUCKET_NAME"
    "REMOTE_STATE_BUCKET_REGION"
    "REMOTE_STATE_KEY"
    "REMOTE_STATE_LOCK_TABLE_NAME"
    "TERRAFORM_ADMIN_ROLE_ARN"
)

VARVALS=(
    "$EKS_CLUSTER_NAME"
    "$REMOTE_STATE_BUCKET_NAME"
    "$REMOTE_STATE_BUCKET_REGION"
    "$REMOTE_STATE_KEY"
    "$REMOTE_STATE_LOCK_TABLE_NAME"
    "$TERRAFORM_ADMIN_ROLE_ARN"
)

len=${#VARNAMES[@]}

for (( i=0; i<len; i++ )) ; do
     if [ -z "${VARVALS[$i]}" ] ; then
         echo "Environment variable '${VARNAMES[$i]}' is not set."
         exit 1
     fi
done
