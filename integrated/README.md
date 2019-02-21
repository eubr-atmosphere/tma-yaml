# TMA-Deployment
In this directory are presented `tma_deployment.yaml` file. This file deploys all components of TMA plataform with Ceph block storage solution.

## Prerequisites

The instructions were tested in `ubuntu`, but should work in other `debian`-based distributions, assuming that you are able to install the key dependencies.

The first step is to install the required components: `docker`, and `kubernetes`.

To install docker, you should execute the following command:

```sh
sudo su -
apt-get install docker.io
```
To install Kubernetes you should execute the following commands:

```sh
sudo su -
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add 
echo -e "deb http://apt.kubernetes.io/ kubernetes-xenial main " >> /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl kubernetes-cni
```

In order to use Kubernetes two machines (nodes) are required with different IP addresses for deploying all necessary pods.

These two nodes communicate through network plugin Flannel.
To initialize the Kubernetes cluster, run the following command in the Master machine:

```sh
swapoff -a
kubeadm init --pod-network-cidr=10.244.0.0/16
```

The output of the command above gives the required commands to complete the setup of Kubernetes cluster. Those commands are:

```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```


Before joining the other node in this cluster, it is necessary to setup the network plugin that is responsible for the communications between Master and Worker nodes.
To do that, run:

```sh
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
ip route add 10.96.0.0/16 dev xxxxxx
```

Where xxxxxx is the network interface name.
After these commands, Master node will be at "Ready" state. For joining the other node, paste the last command of the output of the kubeadm init command in that node. One example of this command can be:

```sh
kubeadm join --token TOKEN MASTER_IP:6443
```

Where TOKEN is the token you were presented after initializing the master and MASTER_IP is the IP address of the master.
Now, the Kubernetes cluster are ready to deploy containers.


## Installation


After completing all steps of the previous section, to deploy the `tma_deployment.yaml` file, you first need to execute the commands presented in this [README](https://github.com/eubr-atmosphere/tma-framework-k/tree/master/development/ceph).
With Ceph correctly configured, need to execute the following commands in Ceph machine:

```sh
ceph auth get-key client.admin
echo [Output of the previous command]| base64
```

After that you need to replace in yaml file in line 393 the key with the one returned by the previous command. Finally, you need to replace the line 449 of the yaml file with the IP or FQDN of Ceph machine.

To deploy TMA_Analyze component, you need to initialize kube-proxy service. To do that, you need to execute the following command:

```sh
kubectl proxy --address kubeserverpublic.localdomain --port=8089  --accept-hosts '.*' &
```

After that, you just need to execute the following command:

```sh
kubectl create -f tma_deployment.yaml
```