#!/bin/sh

# This script is intended to be called with a few positional arguments:
# $1: min kubectl version
# $2: min helm version

MIN_KUBECTL_VERSION="$1"
MIN_HELM_VERSION="$2"

################################
# CHECK BINARIES

for BINARY in helm kubectl aws-iam-authenticator ; do
    if ! [ -x "$(command -v ${BINARY})" ] ; then
        echo "Could not find the '${BINARY}' binary in your \$PATH."
        exit 1
    fi
done

compare_versions() {
    BINARY=$1
    MIN=$2
    CUR=$3
    NEWEST="$(printf "%s\n" "$MIN" "$CUR" | sort -nr | head -n1)"
    if [ \( "$NEWEST" == "$MIN" \) -a \( "$MIN" != "$CUR" \) ] ; then
        echo "Local '${BINARY}' is version ${CUR}. The minimum required version is ${MIN}."
        exit 1
    fi
}

# Output from `kubectl version --short --client` looks like this:
# Client Version: v1.11.2
CUR_KUBECTL_VERSION=$(echo $(kubectl version --short --client) | sed 's/^.*: v//')
compare_versions "kubectl" "${MIN_KUBECTL_VERSION}" "${CUR_KUBECTL_VERSION}"

# Output from `helm version --short --client` looks like this:
# Client: v2.9.1+g20adb27
CUR_HELM_VERSION=$(echo $(helm version --short --client) | sed 's/^.*: v//' | sed 's/+.*$//')
compare_versions "helm" "${MIN_HELM_VERSION}" "${CUR_HELM_VERSION}"

# The aws-iam-authenticator (previously named heptio-authenticator) CLI tool does not have
# a way to retrieve its version, so we can't do a version check for it here.


################################
# CHECK ENV VARS

VARNAMES=(
    "KUBECONFIG"
    "AWS_ACCESS_KEY_ID"
    "AWS_SECRET_ACCESS_KEY"
    "LOG_GROUP_NAME"
)

VARVALS=(
    "$KUBECONFIG"
    "$AWS_ACCESS_KEY_ID"
    "$AWS_SECRET_ACCESS_KEY"
    "$LOG_GROUP_NAME"
)

len=${#VARNAMES[@]}

for (( i=0; i<len; i++ )) ; do
     if [ -z "${VARVALS[$i]}" ] ; then
         echo "Environment variable '${VARNAMES[$i]}' is not set."
         exit 1
     fi
done
