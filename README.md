# Pyramid docker image 

[![Docker Automated build](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)](https://hub.docker.com/r/gerardojunior/pyramid.environment)

Docker image to run [pyramid](https://trypyramid.com/) framework

> The project must be in the **/usr/local/src** (with "public" folder) folder container folder and will be available on port **:80** of the container

## Tags available

- stable
  - [pyhton](https://www.python.org/): 3.5
- latest
  - [pyhton](https://www.python.org/): 3.5

## Come on, do your tests

```bash
docker pull gerardojunior/pyramid.environment:stable
```
## How to build

to build the image you need install the [docker engine](https://www.docker.com/) only

*~ You can try building with different versions of software with docker args, for example: PYTHON_VERISON=7.2.5 ~*
```bash
git clone https://github.com/gerardo-junior/pyramid.environment.git
cd pyramid.environment
docker build . --tag gerardojunior/pyramid.environment
```

## How to use

##### Only with docker command:

```bash
# in your project folder
docker run -it --rm -v $(pwd):/usr/share/src -p 1234:80 gerardojunior/pyramid.environment:stable [sh command ]
```
##### With [docker-compose](https://docs.docker.com/compose/)

Create the docker-compose.yml file  in your project folder with:

```yml
# (...)

  backend: 
    image: gerardojunior/pyramid.environment:stable
    volumes:
      - type: bind
        source: ./
        target: /usr/share/src
    ports:
      - 1234:80

# (...)
```

## How to enter image shell
 
```bash
docker run -it --rm gerardojunior/pyramid.environment:stable sh

# or with docker-compose

docker-compose run backend sh
```

### License  
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
