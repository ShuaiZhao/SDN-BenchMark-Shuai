#!/bin/bash

USERNAME=szb53
Switches="128.104.159.147 128.104.159.148 128.104.159.149"
OVS_BR=ofpbr
CMD_Dump_Flow="hostname; sudo ovs-ofctl -O Openflow13 dump-flows ${OVS_BR}"


for ovs in ${Switches} ; do
   ssh  ${ovs} "${CMD_Dump_Flow}" 
   echo -e "\n"
done
