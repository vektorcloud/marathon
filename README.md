# Marathon

[![circleci][circleci]](https://circleci.com/gh/vektorcloud/marathon)


### Running

    docker run -p 8080:8080 -e MARATHON_ZK=zk://localhost:2181/marathon -e MARATHON_MASTER=zk://localhost:2181/mesos --rm -ti quay.io/vektorcloud/marathon:latest


[circleci]: https://img.shields.io/circleci/build/gh/vektorcloud/marathon?color=1dd6c9&logo=CircleCI&logoColor=1dd6c9&style=for-the-badge "marathon"
