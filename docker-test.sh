#!/bin/bash

while read IMG USR REST; do
  # echo docker pull $IMG
  # docker pull $IMG >/dev/null
  for PROG in su-exec-glibc-shared  su-exec-glibc-static  su-exec-musl-shared  su-exec-musl-static; do
    docker run --rm -e 'LC_ALL=en_US.UTF-8' -e 'TZ=Asia/Shanghai' -v `pwd`:/opt $IMG /opt/$PROG daemon date >/dev/null 2>&1
    RC=$?
    if [ "${RC}0" -eq "0" ] ; then
      echo $IMG $PROG "OK"
    else
      echo $IMG $PROG "XX"
    fi
  done
done << EOF
alpine:3.2
alpine:3.3
alpine:3.4
alpine:3.5
alpine:3.6
alpine:3.7
alpine:3.8
alpine:3.9
centos:5
centos:6
centos:7
debian:6
debian:7-slim
debian:8-slim
debian:9-slim
debian:buster-slim
ubuntu:10.04
ubuntu:12.04
ubuntu:14.04
ubuntu:16.04
ubuntu:18.04
EOF
