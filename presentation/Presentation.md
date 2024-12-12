apps/# random steps:

- Overview
- Table of content
- Introduction of project
- Prerequisites
- Why, When and How?
	  - Pros and Cons
- What is Kubernetes?
- Describe key components of Control-Plane (master node) and Worker Node.
- Options to install Kubernetes like, minikube and kubeadm. 
- What is kubeadm and what are other options for us to choose? 
	  - Why we chose `kubeadm`
	  - What are pros and cons?
- Install "kubeadm" 
- Explain different stages how i prepared to provision complete kubernetes infrastructure.
- All the template and scripts for the provisioning of the infrastructure. 
- 
- Start the `minikube` cluster
	  `minikube start --cpus 4 --memory 4096`
	  Output:
		```bash
		😄  minikube v1.34.0 on Darwin 15.1.1 (arm64)
		✨  Automatically selected the docker driver
		📌  Using Docker Desktop driver with root privileges
		👍  Starting "minikube" primary control-plane node in "minikube" cluster
		🚜  Pulling base image v0.0.45 ...
		🔥  Creating docker container (CPUs=4, Memory=4096MB) ...
		🐳  Preparing Kubernetes v1.31.0 on Docker 27.2.0 ...
		    ▪ Generating certificates and keys ...
		    ▪ Booting up control plane ...
		    ▪ Configuring RBAC rules ...
		🔗  Configuring bridge CNI (Container Networking Interface) ...
		🔎  Verifying Kubernetes components...
		    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
		🌟  Enabled addons: storage-provisioner, default-storageclass
		🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
		```
		- `minikube status` 
		- `minikube version`
		- `minikube stop`
		- `minikube delete`
		- `minikube dashboard` 
		
		
- Create pod (Nginx)
	  `kubectl run nginx --image=nginx `
	  `kubectl get pods`
		  `kubectl get pods -o wide`
	  `kubectl describe pod nginx` - to get detailed information
	  `kubectl exec -it <podName> /bin/bash` - to go into the pods itself
	  Important command: `kubectl get all`
		- pod-defination.yaml
		![[pod-defination-yaml.png]]

- ## Deployments
	- What is deployment?
	- Create deployment file "deployment.yaml"
	  
- ## List of common Kubernetes Deployment-related commands:

	**Deployment Commands**
	
	1. **Create a Deployment**:
	`kubectl create deployment nginx --image=ngin`
	
	Creates a Deployment named nginx with the specified image.

	2. **View Deployments**:
	`kubectl get deployments`
	
	Lists all Deployments in the current namespace.
	
	3. **View Deployment Details**:
	`kubectl describe deployment nginx`
	
	Shows detailed information about the nginx Deployment.
	
	4. **Apply Deployment Configuration**:
	`kubectl apply -f deployment.yaml`

	Creates or updates a Deployment from the specified YAML file.
	
	**Rollout Commands**
	
	5. **Check Rollout Status**:
	`kubectl rollout status deployment/nginx`
	
	Displays the status of the ongoing Deployment rollout.
	
	6. **Undo Rollout**
	`kubectl rollout undo deployment/ngi`

	Rolls back the Deployment to the previous revision.
	
	7. **View Rollout History**:
	`kubectl rollout history deployment/ngin`

	Shows the revision history of the Deployment.
	
	8. **Pause a Rollout**:
	`kubectl rollout pause deployment/nginx`
	
	Pauses an ongoing rollout.
	
	9. **Resume a Rollout**
	`kubectl rollout resume deployment/ngin`
	
	Resumes a paused rollout.
	
	**Scaling Commands**
	
	10. **Scale a Deployment**:
	`kubectl scale deployment/nginx --replicas=5`
	
	Scales the Deployment to 5 replicas.
	
	**Update Commands**
	
	11. **Update Image**:
	`kubectl set image deployment/nginx nginx=nginx:1.20`
	
	Updates the nginx container image in the Deployment.
	
	12. **Apply Changes Declaratively**:
	`kubectl apply -f deployment.yaml`
	
	Applies changes defined in the YAML file to the Deployment.
	
	**View and Debug Commands**
	
	13. **View Pods Created by Deployment**:
	`kubectl get pods -l app=nginx`
	
	Lists pods created by the Deployment with the app=nginx label.
	
	14. **Delete a Deployment**:
	`kubectl delete deployment nginx`
	
	Deletes the nginx Deployment and its associated pods.
	
	15. **Get Logs of a Pod**:
	`kubectl logs <pod-name>`
	
	Fetches logs from a specific pod.
	
	  
	
	These commands cover creating, updating, scaling, managing rollouts, and debugging Deployments efficiently.

- ## Kubernetes Services
  
	- Kubernetes Service Types:
		- ClusterIP
		- NodePort
		- Loadbalancer
	- 