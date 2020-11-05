# Example NodeJS Front invoking a MySQL database through API

Application pattern based on [NodeJS][] using Express server.

Content:

- [Overview](#overview)
- [Requirements](#requirements)
- [Create project](#create-project)
- [Store source code in your Git repository](#store-source-code-in-your-git-repository)
- [Create application using s2i from Catalog](#create-application-using-s2i-from-catalog)
- [Add environment variables to connecto the API example](#add-environment-variables-to-connecto-the-api-example)
- [Update services to expose port 8002](#update-services-to-expose-port-8002)
- [Test application](#test-application)

## Overview

Microservice that implements the front end of an application that accesses a database to perform a simple query.

<p align="center">
  <img src="doc/draw/img/app-oc-items-front.png">
</p>

[OCP]: https://www.openshift.com
[GitHub]: https://github.com
[NodeJS]: https://dev.mysql.com/downloads

## Requirements

- Cluster [OCP][] installed.
- [API "app-items-api" example installed and running.](https://github.ibm.com/CloudExpertLab/OCP/tree/master/applications/examples/app-oc-items-api)
- [MySQL database "app-oc-items-mysql" example installed and running.](https://github.ibm.com/CloudExpertLab/OCP/tree/master/applications/examples/app-oc-items-mysql)
- [GitHub][] account.

## Create project

1. Login to the OpenShift Container Platform.

`$ oc login -u ${OCP4_USER} -p ${OCP4_PASSWORD} ${OCP4_MASTER_API}`

2. Create a new project.

`$ oc new-project app-oc-items-front`

## Store source code in your Git repository

***Note:*** if you have followed the [API "app-items-api" example](https://github.ibm.com/CloudExpertLab/OCP/tree/master/applications/examples/app-oc-items-api), continue from `step 3`.

1. Create a directory to contain the project:

In this example:

`$ mkdir -p /Users/jorgeiglesias/Development/openshift/examples-guide/RH-OpenShift`

2. Go to new directory and create a new repository from scratch:

```
$ cd /Users/jorgeiglesias/Development/openshift/examples-guide/RH-OpenShift
$ git init
```

3. Create a new directory called `app-oc-items-front`

```
$ mkdir app-oc-items-front
```

4. Download de content from `app` directory. The `app-oc-items-front` directory must have this content of files and folders:

```
$ ls -ltr app-oc-items-front
total 16
drwxr-xr-x  3 jorgeiglesias  staff    96  3 nov 13:27 config
drwxr-xr-x  5 jorgeiglesias  staff   160  3 nov 13:28 public
drwxr-xr-x  3 jorgeiglesias  staff    96  3 nov 13:29 routes
drwxr-xr-x  3 jorgeiglesias  staff    96  3 nov 13:29 util
drwxr-xr-x  4 jorgeiglesias  staff   128  3 nov 13:30 views
-rw-r--r--  1 jorgeiglesias  staff  2039  3 nov 13:30 app.js
-rw-r--r--  1 jorgeiglesias  staff   467  3 nov 13:30 package.json
```

5. Commit the changes in the local repo and send the code the remote Git repository:

```
$ git add .
$ git commit -m "Initial version app-oc-items-front"
[master 0b064a9] Initial version
 56 files changed, 2642 insertions(+)
 create mode 100644 app-oc-items-api/app.js
 create mode 100644 app-oc-items-api/config/local.json
 create mode 100644 app-oc-items-api/package.json
 create mode 100644 app-oc-items-api/routes/main.js
 create mode 100644 app-oc-items-api/util/context.js
$ git push
....
remote: Push info collect pre-receive hook finished within 3 seconds.
To github.ibm.com:jorge-iglesias/RH-OpenShift.git
   78c6d4c..0b064a9  master -> master
```

***Note***: in this example we use the `master` branch created by default.

## Create application using s2i from Catalog

1. Open Firefox browser and navigate to https://console-openshift-console.{ocp4-cluster-domain} to access the OpenShift web console. Log into the OpenShift console with your credentials.

2. Switch to the developer perspective using the drop-down menu found at the top of the menu on the left:

<p align="center">
  <img src="doc/img/1.png">
</p>

3. Click `From Catalog`. 

<p align="center">
  <img src="doc/img/1-1.png">
</p>

***Note***: be sure that you have selected the project `app-oc-items-front`.

4. Display a list of technology `Languages` and select `JavaScript`. Click on `MySQL (Ephemeral)`.

<p align="center">
  <img src="doc/img/2.png">
</p>

5. Click `Create application` to display the Create Source-To-Image Application page.

<p align="center">
  <img src="doc/img/2-1.png">
</p>

6. Update the template with following values:

- Builder: `IST:12`

Git:
- Git Repo URL: `git@github.ibm.com:jorge-iglesias/RH-OpenShift.git`

***Note***: `Git repository is not reachable.` if you are using a private repository you have to create a secret with login credentials. This example use SSH Key. You have to create a secret with your own SSH key.

- Git Type: `GitHub`
- Git Reference: `master`
- Context Dir: `app-oc-items-front`
- Source Secret: `ibmgithub`

General
- Application Name: `app-oc-items-front`
- Name: `app-oc-items-front`

Resources:
- Select `Deployment Config`

Advanced Options:
- Enable `Create a route to the application`

7. Click `Create`.

<p align="center">
  <img src="doc/img/3.png">
</p>

<p align="center">
  <img src="doc/img/4.png">
</p>

<p align="center">
  <img src="doc/img/4-1.png">
</p>

8. Click in the application to verify state.

<p align="center">
  <img src="doc/img/5.png">
</p>

## Add environment variables to connecto the API example

You have to add the configuration of the [app-oc-items-api](https://github.ibm.com/CloudExpertLab/OCP/tree/master/applications/examples/app-oc-items-api) API project.

The IP of the database service can be obtained by executing this command:

```
oc get svc -n app-oc-items-api
NAME               TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
app-oc-items-api   ClusterIP   172.30.7.113   <none>        8080/TCP   161m
```

1. In the Administrator perspective. Select `Workloads -> Deployment Configs`:

<p align="center">
  <img src="doc/img/6.png">
</p>

2. Click on DC `app-oc-items-api` and then click on `Environment` tab.

<p align="center">
  <img src="doc/img/7.png">
</p>

3. Add following environment values:

- API_URL=172.30.7.113
- API_PORT=8080

<p align="center">
  <img src="doc/img/8.png">
</p>

4. Scroll down and click `Save`. 

Wait for a new pod to be created with the environment variables set.

<p align="center">
  <img src="doc/img/9.png">
</p>

## Update services to expose port 8002

The NodeJS Express application server in ths example was configured to use port 8002. You must update the service that is created by default 8080.

1. In the Administrator perspective. Select `Networking -> Services` and over the services menu, select `Edit Service.`

<p align="center">
  <img src="doc/img/10.png">
</p>

2. Update the `targetPort` to `8002` and click `Save`.

<p align="center">
  <img src="doc/img/11.png">
</p>

## Test application

1. Login to the OpenShift Container Platform.

`$ oc login -u ${OCP4_USER} -p ${OCP4_PASSWORD} ${OCP4_MASTER_API}`

2. Switch to project app-oc-items-api:

```
$ oc project app-oc-items-front  
Now using project "app-oc-items-front" on server "https://api.blueday.os.fyre.ibm.com:6443".
```

3. Get the route:

```
$ oc get routes
NAME                 HOST/PORT                                                            PATH   SERVICES             PORT       TERMINATION   WILDCARD
app-oc-items-front   app-oc-items-front-app-oc-items-front.apps.blueday.os.fyre.ibm.com          app-oc-items-front   8080-tcp                 None
```

4. Open a browser with `http://app-oc-items-front-app-oc-items-front.apps.blueday.os.fyre.ibm.com`

<p align="center">
  <img src="doc/img/12.png">
</p>

5. Enter user `admin` and password `admin` and click `Login`

<p align="center">
  <img src="doc/img/13.png">
</p>