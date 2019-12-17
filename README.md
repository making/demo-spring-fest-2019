## Spring Fest 2019 Demo

### Prepare demo


```
docker pull cloudfoundry/cnb:bionic
brew tap buildpack/tap && brew install pack
```

```
sdk install java 19.2.1-grl
sdk use java 19.2.1-grl
```


### Run GraalVM Native Image Demo

```
./run-demo-graal.sh
```

### Run CNB Demo

```
./run-demo-cnb.sh
```
