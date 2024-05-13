---
# The Repository is ARCHIVED!
### it is now maintained in https://github.com/ai4os-hub/ai4os-image-classification-tf/
---

<div align="center">
<img src="https://marketplace.deep-hybrid-datacloud.eu/images/logo-deep.png" alt="logo" width="300"/>
</div>

# DEEP as a Service container for image classification

[![Build Status](https://jenkins.indigo-datacloud.eu/buildStatus/icon?job=Pipeline-as-code/DEEP-OC-org/DEEP-OC-image-classification-tf/master)](https://jenkins.indigo-datacloud.eu/job/Pipeline-as-code/job/DEEP-OC-org/job/DEEP-OC-image-classification-tf/job/master)

This is a container that will run the DEEP as a Service API component. From the DEEPaas API the user can choose the model
 to train or to predict, together with the basic input parameters.


## Run the container

### Directly from Docker Hub

To run the Docker container directly from Docker Hub and start using the API
simply run the following command:

```bash
$ docker run -ti -p 5000:5000 -p 6006:6006 -p 8888:8888 deephdc/deep-oc-image-classification-tf
```

This command will pull the Docker container from the Docker Hub
[`deephdc`](https://hub.docker.com/u/deephdc/) organization.

### Building the container

If you want to build the container directly in your machine (because you want
to modify the `Dockerfile` for instance) follow the following instructions:

Building the container:

1. Get the `DEEP-OC-image-classification-tf` repository (this repo):

    ```bash
    $ git clone https://github.com/deephdc/DEEP-OC-image-classification-tf
    ```

2. Build the container:

    ```bash
    $ cd DEEP-OC-image-classification-tf
    $ docker build -t deephdc/deep-oc-image-classification-tf .
    ```

3. Run the container:

    ```bash
    $ docker run -ti -p 5000:5000 -p 6006:6006  -p 8888:8888  deephdc/deep-oc-image-classification-tf
    ```
   
   You can also run Jupyter Lab inside the container:
   
   ```bash
   $ docker run -ti -p 5000:5000 -p 6006:6006 -p 8888:8888 deephdc/deep-oc-image-classification-tf /bin/bash
   $root@47a6604ef008:/srv# jupyter lab --allow-root
   ```
   
These three steps will download the repository from GitHub and will build the
Docker container locally on your machine. You can inspect and modify the
`Dockerfile` in order to check what is going on. For instance, you can pass the
`--debug=True` flag to the `deepaas-run` command, in order to enable the debug
mode.


## Connect to the API

Once the container is up and running, browse to `http://localhost:5000/ui` to get
the [OpenAPI (Swagger)](https://www.openapis.org/) documentation page. If you are
training on your dataset, you can monitor the training progress in Tensorboard 
connecting to `http://localhost:6006`. 
