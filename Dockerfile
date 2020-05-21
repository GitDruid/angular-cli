ARG NODE_VERSION=10

FROM node:$NODE_VERSION

LABEL maintainer="Alessandro Galasso"

ARG IS_ALPINE=false
ARG NG_CLI_VERSION=latest

# ANGULAR
RUN npm install -g @angular/cli@$NG_CLI_VERSION

# ADDITIONAL COMPONENTS: git
RUN if [ "$IS_ALPINE" = "true" ] ; \
    then \
        echo "Node $NODE_VERSION (ALPINE)" && \
        apk update && \
        apk upgrade && \
        apk add --update git && \
        rm -rf /var/lib/apt/lists/* && \
        rm -rf /var/cache/apk/* \
    ; else \
        echo "Node $NODE_VERSION (UBUNTU)" && \
        apt-get update && \
        apt-get install -y --no-install-recommends git && \
        apt-get clean && \
        rm -r /var/lib/apt/lists/* && \
        rm -r /var/cache/* \
    ; fi

#WORKDIR /usr/src/tmp
WORKDIR /usr/src/app
VOLUME /usr/src/app
EXPOSE 4200

# Listen to all the interfaces from the container.
# NOTE 1: "ng serve" is a simple server for use in testing or debugging Angular applications locally.
# NOTE 2: https://stackoverflow.com/questions/40190538/when-to-use-npm-start-and-when-to-use-ng-serve
#CMD cd my-app && ng serve --host 0.0.0.0 
#CMD npm install && ng serve --host 0.0.0.0 
#CMD cd /usr/src/app && ng serve --host 0.0.0.0 
CMD yarn install && ng serve --host 0.0.0.0 




# OTHER VERSIONS
#
# See: https://hub.docker.com/r/binfalse/angular-cli
# See: https://gavinb.net/2017/03/07/docker-on-windows-angular-development/
# See: http://blog.teracy.com/2016/09/22/how-to-develop-angular-2-applications-easily-with-docker-and-angular-cli/
