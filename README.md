# TMA YAML and RADL files
This repository provides YAML and RADL files to deploy the TMA (Trustworthiness Monitoring & Assessment) Framework of ATMOSPHERE in a Kubernetes cluster.

In order to use the TMA Framework, you have to deploy a Kubernetes cluster, that can be done with the IM (Infrastructure Manager). You will need to install the IM server (https://github.com/grycap/im) and the IM client (https://github.com/grycap/im-client). Follow the instructions provided in each link to configure the environment.

The recipes provided in this repo contain the neccessary steps to install the TMA Framework together with the Kubernetes cluster, and the possibility to install CEPH or not.

 - tmaframework.radl: automates the configuration of a Kubernetes cluster with TMA framework, and a node configured with CEPH filesystem.
 - tmaframework_noceph.radl: automates the configuration of a Kubernetes cluster with TMA framework, using the local filesystem.

Choose your prefered option and, with the IM client, execute the following command:

$ ./im_client.py create tmaframework.radl -a auth.dat
$ ./im_client.py getcontmsg <inf_id>
$ ./im_client.py destroy <inf_id>

