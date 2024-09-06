#!/bin/bash

# See [libvirt wiki](https://wiki.libvirt.org/Networking.html#forwarding-incoming-connections)
# for more information.
#
# `cp -T` this script to `/etc/libvirt/hooks/qemu` for it to take effect.
#
# Don't forget to add postrouting masquerade rule too.

if [ "${1}" = "VM NAME" ]; then

   # Update the following variables to fit your setup
   GUEST_IP=
   GUEST_PORT=
   SOURCE_IP=
   HOST_PORT=

   if [ "${2}" = "stopped" ] || [ "${2}" = "reconnect" ]; then
    /sbin/iptables -D FORWARD -o virbr0 -p tcp -d $GUEST_IP --dport $GUEST_PORT -j ACCEPT
    /sbin/iptables -t nat -D PREROUTING -s $SOURCE_IP -p tcp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT
   fi
   if [ "${2}" = "start" ] || [ "${2}" = "reconnect" ]; then
    /sbin/iptables -I FORWARD -o virbr0 -p tcp -d $GUEST_IP --dport $GUEST_PORT -j ACCEPT
    /sbin/iptables -t nat -I PREROUTING -s $SOURCE_IP -p tcp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT
   fi
fi
