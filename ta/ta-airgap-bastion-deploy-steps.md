# TA in  Air-Gap-Bastion mode install

the steps to install:
- install cloudctl a cloud  pak cli
- define all variables at the beginning
- Download the IBM Cloud Transformation Advisor installer   - cloudctl case save
- storing the authentication credentials for all Source Docker registries  - cloudctl case launch.. --action configure-creds-airgap
- login to the cluster
- define variables (again??) in this only more is defined so I took definitions from here and moved them to the beginning
- create autentication credentials (again??)  - cloudctl case launch.. --action configure-creds-airgap…
- Mirror images - cloudctl case launch.. --action mirror-images…
- define varaible for namespace  defined this varaiable at the beginning
- create new-project in cluster
- configure image pull secrets and ICSP  - cloudctl case launch.. --action configure-cluster-airgap…
- Install TA  - cloudctl case launch.. --action install…


Log for all CASE activities is created in **/tmp/case/case.log**

## Install cloudctl:

wget https://github.com/IBM/cloud-pak-cli/releases/latest/download/cloudctl-linux-amd64.tar.gz

or 

curl -L https://github.com/IBM/cloud-pak-cli/releases/latest/download/cloudctl-linux-amd64.tar.gz -o cloudctl-linux-amd64.tar.gz


Define variables:

```
export CASE_NAME=ibm-transadv
export CASE_VERSION=2.5.0
export CASE_ARCHIVE=$CASE_NAME-$CASE_VERSION.tgz
export CASE_INVENTORY_SETUP=v2TransAdvOperator
export OFFLINEDIR=/cdaportdev/ta-offline
export OFFLINEDIR_ARCHIVE=offline.tgz
export CASE_REPO_PATH=https://github.com/IBM/cloud-pak/raw/master/repo/case
export CASE_LOCAL_PATH=$OFFLINEDIR/$CASE_ARCHIVE
export LOCAL_DOCKER_REGISTRY_HOST=cdautil.cda.internal
export LOCAL_DOCKER_REGISTRY_PORT=8447
export LOCAL_DOCKER_REGISTRY=$LOCAL_DOCKER_REGISTRY_HOST:$LOCAL_DOCKER_REGISTRY_PORT
export LOCAL_DOCKER_REGISTRY_USER=admin
export LOCAL_DOCKER_REGISTRY_PASSWORD=ICPassw0rd#
export NAMESPACE=ta
export TA_PROJECT=$NAMESPACE
export ENTITLED_REGISTRY=cp.icr.io
export ENTITLED_REGISTRY_USER=cp
export ENTITLED_REGISTRY_KEY=<entitled registry key>
```

Download the IBM Cloud Transformation Advisor installer
	
```
cloudctl case save \
--repo $CASE_REPO_PATH \
--case $CASE_NAME \
--version $CASE_VERSION \
--outputdir $OFFLINEDIR
```

configure credentials for the entitled and local registry :

```
cloudctl case launch \
--case $CASE_LOCAL_PATH \
--inventory $CASE_INVENTORY_SETUP \
--action configure-creds-airgap \
--args "--registry $ENTITLED_REGISTRY --user $ENTITLED_REGISTRY_USER --pass $ENTITLED_REGISTRY_KEY"
```

```
cloudctl case launch \
--case $CASE_LOCAL_PATH \
--inventory $CASE_INVENTORY_SETUP \
--action configure-creds-airgap \
--args "--registry $LOCAL_DOCKER_REGISTRY --user $LOCAL_DOCKER_REGISTRY_USER --pass $LOCAL_DOCKER_REGISTRY_PASSWORD"
```

Mirror Images

```
cloudctl case launch \
--case $CASE_LOCAL_PATH \
--inventory $CASE_INVENTORY_SETUP \
--action mirror-images \
--args "--registry $LOCAL_DOCKER_REGISTRY --inputDir $OFFLINEDIR"
```

Create Namespace
	
```
oc new-project $NAMESPACE
```

Create imageContentSourcePolicy,...

```
cloudctl case launch \
--case $CASE_LOCAL_PATH \
--inventory $CASE_INVENTORY_SETUP \
--action configure-cluster-airgap \
--namespace $NAMESPACE \
--args "--registry $LOCAL_DOCKER_REGISTRY --user $LOCAL_DOCKER_REGISTRY_USER --pass $LOCAL_DOCKER_REGISTRY_PASSWORD --inputDir $OFFLINEDIR"
```

change the imagecontentsourcepolicy
```
oc edit imagecontentsourcepolicies.operator.openshift.io ibm-transadv
```

add the following lines:
```
  - mirrors:
    - cdautil.cda.internal:8447/cp/icpa
    source: icr.io/appcafe
```

Install Transformation Advisor (this will fail but will continue manually)

```
cloudctl case launch \
--case $CASE_LOCAL_PATH \
--inventory v2InstallProduct \
--namespace $NAMESPACE \
--action install \
--args "--acceptLicense true --licenseType L-AMIK-BYM26G --installTaCatalog true --storageClass managed-nfs-storage --accessMode ReadWriteMany"
```



