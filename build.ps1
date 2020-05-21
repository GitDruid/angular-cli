#docker build . --build-arg NODE_VERSION=14-alpine --build-arg IS_ALPINE=true --build-arg NG_CLI_VERSION=9.1.6 -t galassia/angular-cli:14-9.1.6 -t galassia/angular-cli:latest

docker build . --build-arg NODE_VERSION=14 --build-arg IS_ALPINE=false --build-arg NG_CLI_VERSION=9.1.6 -t galassia/angular-cli:14-9.1.6 -t galassia/angular-cli:latest

#docker push galassia/angular-cli:14-9.1.6
#docker push galassia/angular-cli:latest
