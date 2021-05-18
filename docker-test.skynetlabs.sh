#!/bin/bash

while read IMG REST; do
  # echo docker pull $IMG
  # docker pull $IMG >/dev/null
  PROG=su-exec-musl-static
  docker run --rm -e 'LC_ALL=en_US.UTF-8' -e 'TZ=Etc/UTC' -v `pwd`:/opt $IMG /opt/$PROG daemon date >/dev/null 2>&1
  RC=$?
  if [ "${RC}0" -eq "0" ] ; then
    echo $IMG $PROG "OK"
  else
    echo $IMG $PROG "XX"
  fi
done << EOF
alpine:3.2
alpine:3.3
alpine:3.4
alpine:3.5
alpine:3.6
alpine:3.7
alpine:3.8
alpine:3.9
alpine:3.10
alpine:3.11
centos:5
centos:6
centos:7
centos:8
debian:6
debian:7
debian:8
debian:9
debian:10
ubuntu:10.04
ubuntu:12.04
ubuntu:14.04
ubuntu:16.04
ubuntu:18.04
ubuntu:20.04
registry.access.redhat.com/rhel6
registry.access.redhat.com/rhel7
registry.access.redhat.com/ubi7/ubi
registry.access.redhat.com/ubi8/ubi
registry.suse.com/suse/sles12sp5
registry.suse.com/suse/sle15:15.1
EOF
