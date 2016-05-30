#!/bin/bash
USERNAME=szb53
Switches="128.104.159.147 128.104.159.148 128.104.159.149".
OVS_BR=ofpbr
CMD_Delete_Flow="hostname; sudo ovs-ofctl -O Openflow13 del-flows ${OVS_BR}"

echo "Remove ICMP_LOG"
rm ./network-data2/ofp_icmp_log.db
echo "Remove IPERF_LOG"
rm ./network-data2/ofp_iperf_log.db
echo "Remove ICMP REROUTE"
rm ./network-data2/ofp_icmp_reroute_log.db

for ovs in ${Switches} ; do
   ssh  ${ovs} "${CMD_Delete_Flow}" 
   echo "Deleting flows"
   echo -e "\n"
done
