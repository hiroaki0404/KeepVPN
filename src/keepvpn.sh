#!/bin/bash

. ${HOME}/.keepvpn

cd `dirname "$0"`

while ((1))
do
    ( /sbin/ping -q -c 3 -t 3 "${host}" || ./vpnc connect "${setting}" ) > /dev/null 2>& 1
    if [ "x$1" = "x-once" ]; then
	break;
    fi
    /bin/sleep "${interval}"
done
