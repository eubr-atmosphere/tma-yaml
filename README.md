# TMA YAML and RADL files
This repository provides YAML and RADL files to deploy the TMA (Trustworthiness Monitoring & Assessment) Framework of ATMOSPHERE in a Kubernetes cluster.

In order to use the TMA Framework, you have to deploy a Kubernetes cluster, that can be done with the IM (Infrastructure Manager). You will need to install the IM server (https://github.com/grycap/im) and the IM client (https://github.com/grycap/im-client). Follow the instructions provided in each link to configure the environment.

The recipes provided in this repo contain the neccessary steps to install the TMA Framework together with the Kubernetes cluster, and the possibility to install CEPH or not.

 - tmaframework.radl: automates the configuration of a Kubernetes cluster with TMA framework, and a node configured with CEPH filesystem.
 - tmaframework_noceph.radl: automates the configuration of a Kubernetes cluster with TMA framework, using the local filesystem.

Choose your prefered option and, with the IM client, execute the following command:
```
$ ./im_client.py create <chosen recipe, e.g., tmaframework.radl> -a auth.dat
```
You can get the contextualization logs of the infrastructure with the next command:
```
$ ./im_client.py getcontmsg <inf_id>
```
You can connect with the front-end of the infrastructure with the next command:
```
$ ./im_client.py ssh <inf_id>
```
Finally, when you finished to use your deployment, you can destroy it with the following command:
```
$ ./im_client.py destroy <inf_id>
```
Remember to provide the credentials to access the Fogbow cloud provider in the auth file of the IM:
```
id = fogbow; type = FogBow; host = https://fns-atm-prod-cloud.lsd.ufcg.edu.br; username = <your_user>; password = <your_pass>; domain = <domain>; projectname = <project>
```

Also,if you want to use another image, modify this line of the RADL recipes, by changing the ID of the image:
```
disk.0.image.url = 'fbw://fogbow-ubuntu' and
```

# TMA EC3 recipes
In order to deploy an elastic Kubernetes cluster with the TMA, you have to use the recipes contained in file 'ec3-recipes'.
 
For that, download the EC3 client from here (https://github.com/grycap/ec3), configure properly the credentials to access Fogbow and deploy your cluster with the following command:
 
```
$ ./ec3 launch TMACLUSTER kubernetes-tma tmaframework ubuntu16 -a auth.dat
```
To access the cluster once it is ready, use the following command:
```
$ ./ec3 ssh TMACLUSTER
```
Finally, to delete the cluster, use this command:
```
$ ./ec3 destroy TMACLUSTER
```
