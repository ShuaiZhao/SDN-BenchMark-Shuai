#!/bin/bash
USERNAME=szb53
Switches="128.104.159.147 128.104.159.148 128.104.159.149"
OVS_BR=ofpbr
CMD_check_Flow="hostname;sudo ovs-vsctl show"
CMD_check_Port='sudo ovs-ofctl show ofpbr -O openflow13'

for ovs in ${Switches} ; do
   ssh  ${ovs} "${CMD_check_Flow}" 
   echo -e "\n"
   ssh  ${ovs} "${CMD_check_Port}" 
done
