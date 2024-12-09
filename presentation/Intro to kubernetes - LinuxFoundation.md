# Introduction

Here we will learn all about kubernetes.

Commands for get familiarise with:
- to get the nodes
  `kubectl get nodes`
- to get extra detailed information like (linuxOS, versions of nodes etc..) 
  `kubectl get nodes -o wide`
- **Create an NGINX Pod**
  `kubectl run nginx --image=nginx`
  As of version 1.18, kubectl run (without any arguments such as_ `--generator` ) will create a pod instead of a deployment.

- To create a deployment using imperative command, use **kubectl create:**
  `kubectl create deployment nginx --image=nginx`
  - Note: 
	• Use kubectl run for simple, unmanaged tasks or quick testing.
	• Use kubectl create deployment for production-ready, scalable, and resilient workloads.
- ![[2024Dec04.png]]
- ## Advanced Minikube Features 

	Most **minikube** commands, such as start, stop, node, etc. are profile aware, meaning that the user is required to explicitly specify the target cluster of the command, through its profile name. The default minikube cluster, however, can be managed implicitly without specifying its profile name. Stopping and re-starting the two clusters listed above, the minibox cluster (explicitly) and the default minikube cluster (implicitly):
	
	**$ minikube stop -p minibox**
	
	**$ minikube start -p minibox**
	
	**$ minikube stop**
	
	**$ minikube start**
	
	Additional helpful **minikube** commands:
	
	To display the version of the current Minikube installation:
	
	**$ minikube version**
	
	**minikube version: v1.32.0**  
	**commit: 8220a6eb95f0a4d75f7f2d7b14cef975f050512d**
	
	Completion is a helpful post installation configuration to enable the **minikube** command to respond to typical auto-completion mechanisms, such as completing a command in the terminal by pressing the TAB key. To enable completion for the bash shell on Ubuntu:
	
	**$ sudo apt install bash-completion**
	
	**$ source /etc/bash_completion**
	
	**$ source <(minikube completion bash)**
	
	If needed, also run the following command:
	
	**$ minikube completion bash**
	
	A command that allows users to list the nodes of a cluster, add new control plane or worker nodes, delete existing cluster nodes, start or stop individual nodes of a cluster:
	
	**$ minikube node list**
	
	**minikube 192.168.59.100**
	
	**$ minikube node list -p minibox**
	
	**minibox   192.168.59.101  
	minibox-m02   192.168.59.102  
	minibox-m03   192.168.59.103**
	
	To display the cluster control plane node's IP address, or another node's IP with the **--node** or **-n** flags:
	
	**$ minikube ip**
	
	**192.168.59.100**
	
	**$ minikube -p minibox ip**
	
	**192.168.59.101**
	
	**$ minikube -p minibox ip -n minibox-m02**
	
	**192.168.59.102**
	
	When a cluster configuration is no longer of use, the cluster's profile can be deleted. It is also a profile aware command - it deletes the default minikube cluster if no profile is specified, or a custom cluster if its profile is specified:
	
	**$ minikube delete**
	
	**🔥  Deleting "minikube" in virtualbox ...**  
	**💀  Removed all traces of the "minikube" cluster.**
	
	**$ minikube delete -p minibox**
	
	**🔥  Deleting "minibox" in virtualbox ...**  
	**🔥  Deleting "minibox-m02" in virtualbox ...**  
	**🔥  Deleting "minibox-m03" in virtualbox ...**  
	**💀  Removed all traces of the "minibox" cluster.**
	
	For additional commands and usage options please visit the [Minikube command line reference](https://minikube.sigs.k8s.io/docs/commands/).

- 



## From Monolith to Microservices
- **Beginner-Friendly Explanation: The Legacy Monolith**
  
	A **monolith application** is like a giant rock that’s tough to move. These apps are old, built with outdated tools, and full of complex, messy code. Here’s why they’re tricky:
	
	1. **Complexity**: Over time, new features and fixes make the code harder to manage, slowing everything down.
	
	2. **Hardware Hungry**: They need powerful (and expensive) hardware to run because they’re a single big piece of software.
	
	3. **Scaling Issues**: You can’t easily grow one part of the app. To handle more users, you must duplicate the whole app on another server, which costs a lot.
	
	4. **Downtime**: Updating or fixing the app often means it stops working temporarily, which can annoy users.
	
	  
	
	In short, monolith apps are heavy, hard to scale, and costly to maintain. That’s why many companies are exploring modern alternatives like breaking these big apps into smaller, more flexible parts.

- **Beginner-Friendly Explanation: The Modern Microservice**

	A **microservice** is a small, independent piece of software that performs a specific task within a larger application. It communicates with other microservices through APIs, making the app modular, scalable, and easier to update or manage.
	
	1. **Small and Focused**: Each microservice is like a pebble, handling just one specific task. Together, they perform all the functions of the original big app but are easier to manage.
	
	2. **Efficient Use of Resources**: Microservices run independently on smaller servers, using only the resources they need. This saves money compared to powering a giant monolith.
	
	3. **Communication with APIs**: Microservices communicate through APIs (kind of like messengers) to work together, allowing them to easily connect with other apps or services.
	
	4. **Flexibility**: Each microservice can use the best tools and programming language for its specific job, making them adaptable and efficient.
	
	5. **Scalability**: Need more capacity? Scale only the service that’s under heavy load instead of duplicating the whole app. This can even be automated based on demand.
	
	6. **Quick Updates**: Since each service is independent, you can update or fix one without stopping the entire app. This means no downtime for users and faster feature releases.
	
	  
	
	In short, microservices are modular, cost-effective, and agile, making them ideal for modern applications.

- **Beginner-Friendly Explanation: What is Refactoring?**
	
	Refactoring is the process of transforming a legacy monolith app into modern microservices. It’s like breaking a big, outdated machine into smaller, efficient parts.
	
	**Approaches to Refactoring:**
	
	1. **Big-Bang Refactoring**:
	
		• Completely rebuild the app as microservices.
		
		• Risky, delays new features, and might disrupt the business.
	
	2. **Incremental Refactoring**:
	
		• Slowly turn parts of the monolith into microservices.
		
		• New features are added as microservices, while old features are modernized over time.
		
		• Easier transition with fewer risks.
	
	3. **Key Challenges:**
	
		• Deciding which parts of the monolith to turn into microservices.
		
		• Separating the database and simplifying data connections.
		
		• Testing microservices and their dependencies.
	
	**Outcome:**
		Refactoring gives old monolith apps a second life by making them modular, cloud-ready, and easier to maintain in today’s fast-paced tech environment.

- **Beginner-Friendly Explanation: Challenges of Refactoring**

	Refactoring a monolith into microservices is not easy. Here are the main challenges:
	
	1. **Not All Monoliths Can Be Refactored**:
	
		• Old systems like those built with Cobol or Assembler may need to be rebuilt entirely as cloud-native apps.
	
		• Poorly designed apps or tightly connected to their databases are also bad candidates for refactoring.
	
	2. **Keeping Modules Alive**:
	
		• Once the app is split into smaller parts (microservices), ensuring all parts work together reliably is hard.
	
	3. **Runtime Conflicts**:
	
		• Running multiple modules on the same server can cause errors due to conflicting libraries or environments.
		
		• Splitting each module to its own server solves this but wastes resources.
	
	**The Solution: Containers**
	- **Containers** solve these challenges by:
		
		• Providing lightweight, isolated environments for each microservice, avoiding conflicts.
		• Allowing multiple containers to run on the same server, using resources efficiently.
		• Making it easier to scale, test, and integrate microservices into automated workflows.
		
		Containers ensure microservices work smoothly, saving costs and improving flexibility.

## Container Orchestration

- Container orchestration is like managing a group of workers (containers) to ensure they work together efficiently and reliably. Here’s the idea:

	1. **What Are Containers?**
	
		Containers package application code, runtime, and dependencies into a neat bundle, making them easy to run anywhere.
	
	2. **Why Do We Need Orchestration?**
	
		Running containers on a single machine is simple, but we often need:
		
		• **Scalability**: Add more containers when demand increases.
		
		• **Fault Tolerance**: Automatically recover if something goes wrong.
		
		• **Management**: Handle multiple machines (hosts) and containers together.
	
	3. **What Is Container Orchestration?**
		
		A **container orchestrator** is a tool that manages and automates containers across multiple machines, making them work as one system. It ensures:
	
		• Containers are deployed where needed.
		
		• They scale up or down automatically.
		
		• They recover from failures.
	
	4. **Examples of Container Orchestrators**:
	
		• Kubernetes (most popular).
		
		• Docker Swarm.
		
		• Amazon ECS/EKS.
	
	**Why It’s Important**
		Container orchestration makes applications reliable, scalable, and easier to manage, especially in cloud environments.

- What Are Containers?**

	A **container** is like a portable box for your application. It holds:
	
	• **Code**: Your app’s logic.
	• **Runtime**: The environment your app needs to run (e.g., programming language).
	• **Dependencies**: Tools, libraries, or files your app relies on.
	
	**Why Use Containers?**

	1. **Consistency**: The app runs the same on any computer, server, or cloud.
	2. **Efficiency**: Containers are lightweight and use fewer resources than full virtual machines.
	3. **Isolation**: Each container runs independently, so problems in one don’t affect others.
	
	In short, containers make it easier to develop, test, and deploy apps anywhere.

- **Container Deployment**
	Containers package microservices with everything they need (runtime, libraries, dependencies) to run. They rely on **container images**, which serve as the blueprint. These images are deployed as containers on various platforms like **workstations**, **Virtual Machines**, or the **cloud**, offering isolated and consistent environments for applications.

- What Is Container Orchestration?

	In Development (Dev) environments, running containers on a single host for development and testing of applications may be a suitable option. However, when migrating to Quality Assurance (QA) and Production (Prod) environments, that is no longer a viable option because the applications and services need to meet specific requirements:
	
	- Fault-tolerance
	- On-demand scalability
	- Optimal resource usage
	- Auto-discovery to automatically discover and communicate with each other
	- Accessibility from the outside world
	- Seamless updates/rollbacks without any downtime.
	
	Container orchestrators are tools which group systems together to form clusters where containers' deployment and management is automated at scale while meeting the requirements mentioned above. The clustered systems confer the advantages of distributed systems, such as increased performance, cost efficiency, reliability, workload distribution, and reduced latency.

- **Where to Deploy Container Orchestrators?**
	Container orchestrators, like Kubernetes, are highly flexible and can be deployed on various platforms:
	
	1. **On-Premises**:
	
		• **Bare Metal**: Directly on physical servers for maximum performance.
		
		• **Virtual Machines**: Inside company data centers for flexibility and isolation.
	
	2. **Public Cloud**:
	
		• Deploy on cloud infrastructure like AWS EC2, Google Compute Engine (GCE), or DigitalOcean Droplets for scalability.
	
	3. **Hybrid Cloud**:
	
		• Combine on-premises and cloud resources to optimize cost and performance.
	
	4. **Local Workstation**:
	
		• For testing and development, using tools like Minikube or kind.
	
	**Managed Kubernetes as-a-Service (KaaS)**
	Major cloud providers offer **managed Kubernetes services** that handle setup and maintenance, making it easier to deploy production clusters:
	
	• **Amazon EKS** (AWS)
	• **Azure AKS** (Microsoft)
	• **Google GKE** (Google Cloud)
	• **DigitalOcean Kubernetes**
	• **IBM Cloud Kubernetes Service**
	• **VMware Tanzu Kubernetes Grid**
	
	These services simplify deployment, allowing you to focus on application management rather than infrastructure setup.

