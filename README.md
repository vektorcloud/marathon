# Marathon
[![Circle CI](https://circleci.com/gh/vektorcloud/marathon.svg?style=svg)](https://circleci.com/gh/vektorcloud/marathon)


### Running

    docker run -p 8080:8080 -e MARATHON_ZK=zk://localhost:2181/marathon -e MARATHON_MASTER=zk://localhost:2181/mesos --rm -ti quay.io/vektorcloud/marathon:latest

