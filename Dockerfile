FROM ubuntu:latest

# Install packages
RUN apt-get update; apt-get -y install dig curl wget nano jq 


# Install oc and kubectl
RUN wget --https-only -o oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && tar xf oc.tar.gz && mv oc kubectl /usr/local/bin
