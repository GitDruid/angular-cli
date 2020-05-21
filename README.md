# Docker Angular-cli

A Docker image for angular applications development.

## Building the angular-cli container

See the ./build.ps1 PowerShell command.

## Creating a new angular app

    docker run --rm -it -v /PATH/TO/APP:/usr/src/app galassia/angular-cli ng new YOUR-APP-NAME

### Example

    mkdir MyProjects
    cd MyProjects
    docker run --rm -it -v ${PWD}:/usr/src/app galassia/angular-cli ng new MySampleApp --skip-install

Here I'm avoiding installation trough "ng new" since it takes longer than other install procedures.  
Additionally it often rises some trouble during filesystem operations on a mapped volume on Windows host.  
A solution that seems to work well is to use yarn in CMD.  

Credits:

https://github.com/angular/angular-cli/issues/8684  
https://stackoverflow.com/questions/15393821/npm-err-cb-never-called  

## Running your angular app

    docker run --name YOUR-CONTAINER-NAME -d -v /PATH/TO/APP:/usr/src/app -p 4200:4200 galassia/angular-cli

### Example

    cd MyProjects
    cd MySampleApp
    docker run --name MySampleApp -d -v ${PWD}:/usr/src/app -p 4200:4200 galassia/angular-cli

After a few seconds (may be more in case of first install) of server startup, you can find your app running at http://localhost:4200 on your host.

## Compile and release your app

    docker run --rm -it -v /PATH/TO/APP:/usr/src/app galassia/angular-cli ng build --prod --bh / -d /

This will compile a release into the dist/ of /PATH/TO/APP, so you may just run an nginx to serve the files:

    docker run --rm -it -p 8080:80 -v /PATH/TO/APP/dist:/usr/share/nginx/html:ro nginx

Your app will be available at http://localhost:8080

## Troubleshooting

In my environment (Docker Desktop for Windows 10), I often experienced errors while creating the app (during the dependency install step):

	npm ERR!   syscall: 'rename'

It is  not really clear what's the reason for this error (and similar others).
Some workarounds:

- Close vs code
- Suspend the antivirus
- Execute PowerShell as administrator
- Add --force flag to npm install
- Replace npm with yarn

Additional info here:

https://stackoverflow.com/questions/39293636/npm-err-error-eperm-operation-not-permitted-rename  
https://github.com/Microsoft/WSL/issues/2097  
https://www.turek.dev/post/fix-wsl-file-permissions/  
https://gavinb.net/2017/03/07/docker-on-windows-angular-development/  

## Credits

https://hub.docker.com/r/binfalse/angular-cli  
https://github.com/teracyhq/docker-files/tree/master/angular-cli  

