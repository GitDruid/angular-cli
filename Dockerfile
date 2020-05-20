ARG NODE_VERSION=10

FROM node:$NODE_VERSION

LABEL maintainer="Alessandro Galasso"

ARG IS_ALPINE=false
ARG NG_CLI_VERSION=latest

# install some common dependencies
#RUN npm install --unsafe-perm -g @angular/cli findup-sync typescript 
RUN npm install -g @angular/cli@$NG_CLI_VERSION

RUN if [ "$IS_ALPINE" = "true" ] ; \
    then \
        echo $NODE_VERSION (ALPINE) && \
        apk update && \
        apk upgrade && \
        apk add --update git less openssh && \
        rm -rf /var/lib/apt/lists/* && \
        rm -rf /var/cache/apk/* \
    ; else \
        echo $NODE_VERSION (UBUNTU) && \
        apt-get update \
        && apt-get install -y --no-install-recommends \
        git \
        && apt-get clean \
        && rm -r /var/lib/apt/lists/* /var/cache/* \
    ; fi

WORKDIR /usr/src/app
#VOLUME /usr/src/app
EXPOSE 4200

#temp
RUN ng new my-app

# Listen to all the interfaces from the container.
CMD cd my-app && ng serve --host 0.0.0.0 
#CMD cd my-app && npm install && npm start

# See: https://hub.docker.com/r/binfalse/angular-cli


# OTHER VERSIONS
#
# See: https://gavinb.net/2017/03/07/docker-on-windows-angular-development/
# See: http://blog.teracy.com/2016/09/22/how-to-develop-angular-2-applications-easily-with-docker-and-angular-cli/
