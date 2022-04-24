# Learn Terraform - Provision a GKE Cluster - Deploy

This repo is test to create a cluster with terraform and deploy a (RoR) instance
This sample repo also creates a VPC and subnet for the GKE cluster.
At the end of this test, you will know more about Terraform, Kubernetes (on Google Cloud)

#Install terraform
https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/gcp-get-started

#Create project
Go to https://console.cloud.google.com/projectcreate

fill in a project name, like :mobiel-nl-test

click "Create" 

#Enable API's
Go to: https://console.cloud.google.com/apis/dashboard
enable:
 - Compute Engine API
 - Kubernetes Engine API

#Add service account
We want to enable access to our project when executing commands.

Log into your Google Cloud Console, navigate to APIs and Services 
-> Credentials -> Create credentials and create a new Service account key.
    - choose role: owner
click  the service account name
click 'keys'
click 'add key'
choose existing key
keep type on " json"
save as 'mobiel-nl-test.json' in root of project


#Install gcloud CLI
https://cloud.google.com/sdk/docs/install
#initialize
https://cloud.google.com/sdk/docs/initializing

#create repository
Run the following command to create a repository named hello-repo in the same region as your cluster:
```
gcloud artifacts repositories create hello-repo \
--project=PROJECT_ID \
--repository-format=docker \
--location=europe-west4 \
--description="Docker repository"
```
`PROJECT_ID` is your Google Cloud project ID

`artifactregistry.googleapis.com` may be enabled when asked

#build image and push to repository
```
 gcloud builds submit \
    --tag europe-west4-docker.pkg.dev/PROJECT_ID/hello-repo/helloworld-gke src/.
```
`PROJECT_ID` is your Google Cloud project ID
`cloudbuild.googleapis.com` may be enabled when asked


#Create service account for pulling images

 Do the same as previous service account except:
  - Role: Actions Viewer
  - Save with a different name

Now you need to tell Kubernetes to use the JSON key file when pulling from GCR by creating a secret named gcr-json-key.

```
kubectl create secret docker-registry gcr-json-key 
--docker-server=eu.gcr.io \
--docker-username=_json_key \
--docker-password="$(cat ~/json-key-file.json)" \
--docker-email=any@valid.email
```
Replace ~/json-key-file.json with the path to your json key file.

Be carefull with spaces and change of `"` and '--', when modified it will not succeed.

Finally, you have to add the secret to your default service account as `ImagePullSecrets`, so it will actually be used, when Kubernetes spins up a new pod with this service account.
```
kubectl patch serviceaccount default \
-p '{"imagePullSecrets": [{"name": "gcr-json-key"}]}'
```

check if imagePullSecrets is enabled:

```
kubectl get serviceaccount default -o yaml
```

#Create the cluster (and deploy resources and load balancer)
```
terraform init
```
```
terraform validate
```
```
terraform apply -auto-approve
```


#Deploy an app
for now the deployment is not working in terraform, so we try with kubectl
```
kubectl apply -f deployment.yaml
```
#Deploy a lood balancer
For now the deployment of a load balancer service is not working in terraform, so we try with kubectl
```
kubectl apply -f deployment.yaml
```

For some reason is the image for the pod corrupt, so it restarts after crashing