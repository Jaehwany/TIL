## Jenkins + Docker 활용한 CI/CD 구축


### Docker 설치

```

https://docs.docker.com/get-docker

```

<br>

### Jenkins 설치

```
Docker run -d –name Jenkins –p 9090:8080
	    -v /var/Jenkins:/var/Jenkins_home
	    -v /var/run/docker.sock:/var/run/docker.sock
	    -u root Jenkins/Jenkins:latest
```

<br>

### Docker Install in Jenkins

```
curl https://get.docker.com/ > dockerinstall && chmod 777 dockerinstall && ./dockerinstall

```
