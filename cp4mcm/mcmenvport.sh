#! /bin/bash

export CASE_ARCHIVE=ibm-cp-management-100.3.25+2.3.24.tgz
export CASE_INVENTORY_SETUP=cp4mcmInstallerSetup
export OFFLINE_DIR=/202204MCMReg
export OFFLINE_ARCHIVE=offline.tar
export CASE_LOCAL_PATH=$OFFLINEDIR/$CASE_ARCHIVE

# variables for External registry
export EXTERNAL_DOCKER_REGISTRY=onreg.benoibm.com:443
export EXTERNAL_DOCKER_USER=admin
export EXTERNAL_DOCKER_PASSWORD=ICPassw0rd#
export EXTERNAL_DOCKER_REGISTRY_DIR=/mnt/docker_images
# This registry dir is in the MCM portable storage device procedure a folder withing offlline directory $OFFLINE_DIR/cp4mcm-registry because the whole offline folder was compressed and transferred to the offreg server. 

# variables for portable registry
export PORTABLE_DOCKER_REGISTRY_HOST=offreg.benoibm.com
export PORTABLE_DOCKER_REGISTRY_PORT=443
export PORTABLE_DOCKER_REGISTRY=$PORTABLE_DOCKER_REGISTRY_HOST:$PORTABLE_DOCKER_REGISTRY_PORT
export PORTABLE_DOCKER_USER=admin
export PORTABLE_DOCKER_PASSWORD=ICPassw0rd#
export PORTABLE_DOCKER_REGISTRY_DIR=/opt/docker_images/docker_images

# variables for local registry
export LOCAL_DOCKER_REGISTRY=${PORTABLE_DOCKER_REGISTRY}
export LOCAL_DOCKER_USER=${PORTABLE_DOCKER_USER}
export LOCAL_DOCKER_PASSWORD=${PORTABLE_DOCKER_PASSWORD}


# vatiables for cluster and entitlement
export NAMESPACE=cp4mcm
export CS_NAMESPACE=ibm-common-services
export ENTITLED_REGISTRY=cp.icr.io
export ENTITLED_REGISTRY_USER=cp


echo "Please enter the IBM entitlement key or leave empty if you have the key set already:"
read ibm_ent_reg_key

if [ -z "$ibm_ent_reg_key" ]
then
      if [ -z "$ENTITLED_REGISTRY_KEY" ]
      then
           echo "enter the ibm entitled registry key"
      else
           echo "the ibm entitlement registry variable set earlier will be used"
      fi	
else
      export ENTITLED_REGISTRY_KEY=$ibm_ent_reg_key
      echo "the variable for the ibm entitled registry key has been set"
fi

# export ENTITLED_REGISTRY_KEY=$ibm_ent_reg_key

# in case new tmp directory is needed uncoment the next line
# export TMPDIR=/cdaportdev/tmp/

echo "seting variables is complete"