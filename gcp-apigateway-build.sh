#!/bin/bash
#Sample values for project and API gateway name
#PROJECT_ID = "us-gcp-ame-its-gpt-npd-1"
#API_NAME = "gcpcmsauth"

PROJECT_ID=$1
API_NAME=$2
#Enable required APIs in Cloud Shell, run the following commands to enable the required service
gcloud config set project $PROJECT_ID
gcloud services enable container.googleapis.com
gcloud services enable apigateway.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable servicemanagement.googleapis.com
gcloud services enable servicecontrol.googleapis.com
gcloud services enable iap.googleapis.com

#Create the API gateway config by running the following command
gcloud api-gateway api-configs create gcp-cms-api-config --api=$API_NAME --openapi-spec=gcp-cms-api-config.yaml --project=$PROJECT_ID

#deploy the API config to a gateway, run the below command
gcloud api-gateway gateways create gcp-cms-api-gateway --api=$API_NAME --api-config=gcp-cms-api-config --location=us-east4 --project=$PROJECT_ID

#run the below commands to view details about the gateway
gcloud api-gateway gateways describe gcp-cms-api-gateway --location=us-east4 --project=$PROJECT_ID

#Enable the created api in API & Service page
#MANAGED_SERVICE_NAME=$(gcloud api-gateway apis describe gcpcmsauth --format="value(managedService)")
#gcloud services enable $MANAGED_SERVICE_NAME