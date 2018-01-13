# Marathon

![circleci][circleci]


### Running

    docker run -p 8080:8080 -e MARATHON_ZK=zk://localhost:2181/marathon -e MARATHON_MASTER=zk://localhost:2181/mesos --rm -ti quay.io/vektorcloud/marathon:latest


[circleci]: https://img.shields.io/circleci/project/github/vektorcloud/marathon.svg "marathon"
