FROM ubuntu:latest

LABEL maintainer="Tobias Derksen<tobias.derksen@codecentric.de>"

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Install packages
RUN apt-get update; apt-get -y install curl wget nano jq git dnsutils postgresql-client mysql-client; rm -rf /var/cache/apt


# Install oc and kubectl
RUN wget --https-only -O oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && tar xf oc.tar.gz && mv oc kubectl /usr/local/bin && rm -f oc.tar.gz

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "sleep 100000000" ]