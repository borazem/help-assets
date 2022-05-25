#! /bin/bash

echo " CASE_ARCHIVE is: " $CASE_ARCHIVE
echo " CASE_INVENTORY_SETUP is: " $CASE_INVENTORY_SETUP
echo " OFFLINE_DIR is: " $OFFLINE_DIR
echo " OFFLINE_ARCHIVE is: " $OFFLINE_ARCHIVE
echo " CASE_LOCAL_PATH is: " $CASE_LOCAL_PATH

# variables for External registry
echo " EXTERNAL_DOCKER_REGISTRY is: " $EXTERNAL_DOCKER_REGISTRY
echo " EXTERNAL_DOCKER_USER is: " $EXTERNAL_DOCKER_USER
echo " EXTERNAL_DOCKER_PASSWORD is: " $EXTERNAL_DOCKER_PASSWORD
echo " EXTERNAL_DOCKER_REGISTRY_DIR is: " $EXTERNAL_DOCKER_REGISTRY_DIR
# This registry dir is in the MCM portable storage device procedure a folder withing offlline directory $OFFLINE_DIR/cp4mcm-registry because the whole offline folder was compressed and transferred to the offreg server. 

# variables for portable registry
echo " PORTABLE_DOCKER_REGISTRY_HOST is: " $PORTABLE_DOCKER_REGISTRY_HOST
echo " PORTABLE_DOCKER_REGISTRY_PORT is: " $PORTABLE_DOCKER_REGISTRY_PORT
echo " PORTABLE_DOCKER_REGISTRY is: " P$ORTABLE_DOCKER_REGISTRY
echo " PORTABLE_DOCKER_USER is: " $PORTABLE_DOCKER_USER
echo " PORTABLE_DOCKER_PASSWORD is: " $PORTABLE_DOCKER_PASSWORD
echo " PORTABLE_DOCKER_REGISTRY_DIR is: " $PORTABLE_DOCKER_REGISTRY_DIR

# variables for local registry
echo " LOCAL_DOCKER_REGISTRY is: " $LOCAL_DOCKER_REGISTRY
echo " LOCAL_DOCKER_USER is: " $LOCAL_DOCKER_USER
echo " LOCAL_DOCKER_PASSWORD is: " $LOCAL_DOCKER_PASSWORD


# vatiables for cluster and entitlement
echo " NAMESPACE is: " $NAMESPACE
echo " CS_NAMESPACE is: " $CS_NAMESPACE
echo " ENTITLED_REGISTRY is: " $ENTITLED_REGISTRY
echo " ENTITLED_REGISTRY_USER is: " $ENTITLED_REGISTRY_USER
echo " ENTITLED_REGISTRY_KEY is: " $ENTITLED_REGISTRY_KEY

echo "TMPDIR is:"  $TMPDIR

