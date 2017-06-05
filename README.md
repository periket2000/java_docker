# java_docker

Image for running java spring boot based git projects.

## Java projects

Should have and structure like the following:

```
${PROJECT_DIR} +
               |
               +-> README.md
               +-> ...
               +-> ${SRC_DIR} + 
                              |
                              + target/app-vxx.jar (file to be run)
```

Should expose an endpoint that will be the one that we expose in docker.

Check https://github.com/periket2000/gs-rest-service.git, is a Spring Boot app that
exposes the api in 8080 port.

You can configure the app through the "env" property in the json file, in this
case: 

```
PROJECT_DIR: where everything will be installed inside the container.
GIT_REPO: the repo to download.
SRC_DIR: the source folder inside the project.
APP_FILE: entry point to python application.
```

## sample mesos application json, let's say py-docker.json (see doc/mesos/)

```json
        {
          "id": "java-docker",
          "instances": 1,
          "cpus": 1,
          "mem": 100,
          "constraints": [["hostname", "UNIQUE", ""]],
          "env": {
              "PROJECT_DIR": "/usr/local/javaenv",
              "GIT_REPO": "https://github.com/periket2000/gs-rest-service.git",
              "SRC_DIR": "complete",
              "APP_FILE": "target/gs-rest-service-0.1.0.jar"
          },
          "container": {
            "type": "DOCKER",
            "docker": {
              "image": "periket2000/java_docker:v1.0",
              "network": "BRIDGE",
              "portMappings": [
                {
                  "containerPort": 8080,
                  "hostPort": 0,
                  "servicePort": 0,
                  "protocol": "tcp"
                }
              ]
            }
          },
          "healthChecks": [
              {
                "protocol": "HTTP",
                "portIndex": 0,
                "path": "/greeting",
                "gracePeriodSeconds": 5,
                "intervalSeconds": 20,
                "maxConsecutiveFailures": 3
              }
            ]
        }
```

## Sample load on mesos
```sh
curl -X POST http://<marathon_host>:<marathon_port>/v2/apps -d @<file> -H "Content-type: application/json"
curl -X POST http://192.168.250.101:8080/v2/apps -d @app.json -H "Content-type: application/json"
```

## How to run it in local (requires docker)
```sh
git clone https://github.com/periket2000/java_docker.git
cd java_docker
docker build -t mytag .
docker run -p 9999:8080 --env-file=env.sh mytag
```

and point your browser to "http://localhost:9999/greeting"
