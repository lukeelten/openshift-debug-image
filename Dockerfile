FROM ubuntu:latest

LABEL maintainer="Tobias Derksen<tobias.derksen@codecentric.de>"

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Install packages
RUN apt-get update; apt-get -y install curl wget nano jq git gnupg2 dnsutils postgresql-client mysql-client; rm -rf /var/cache/apt

# Install podman
RUN . /etc/os-release && echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list

RUN . /etc/os-release && wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O - | apt-key add -
RUN apt-get update -y && apt-get --yes install podman skopeo buildah && rm -rf /var/cache/apt

RUN sed -i 's/driver = "overlay"/driver = "vfs"/' /etc/containers/storage.conf

# Install oc and kubectl
RUN wget --https-only -O oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && tar xf oc.tar.gz && mv oc kubectl /usr/local/bin && rm -f oc.tar.gz

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "sleep 100000000" ]