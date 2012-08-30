#!/bin/bash

. ${HOME}/.keepvpn

cd `dirname "$0"`

if [ "1" = "${ipv6}" ]; then
    ping="/sbin/ping6"
else
    ping="/sbin/ping"
fi
while ((1))
do
    ( ${ping} -q -c 3 "${host}" || ./vpnc connect "${setting}" ) > /dev/null 2>& 1
    if [ "x$1" = "x-once" ]; then
	break;
    fi
    /bin/sleep "${interval}"
done
