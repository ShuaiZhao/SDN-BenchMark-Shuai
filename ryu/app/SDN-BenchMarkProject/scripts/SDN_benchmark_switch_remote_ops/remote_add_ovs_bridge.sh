#!/bin/bash
set -u
Switches="128.104.159.147 128.104.159.148 128.104.159.149"

# The OVS bridge you wanna create
OVS_BRIDGE=ofpbr
SDN_CONTROLLER="204.76.187.50"


CMD1="hostname"
CMD2="sudo ovs-vsctl add-br ${OVS_BRIDGE}"
CMD3="sudo ovs-vsctl set-controller ${OVS_BRIDGE} tcp:${SDN_CONTROLLER}:6633"
CMD4="sudo ovs-vsctl set-fail-mode ${OVS_BRIDGE} secure"
CMD5="sudo ovs-vsctl set bridge ${OVS_BRIDGE} protocols=OpenFlow13"

CMD7="sudo ovs-vsctl show"

#DATAPATH-ID-1="0000000000000001"
#DATAPATH-ID-2="0000000000000002"
#DATAPATH-ID-3="0000000000000003"
#DATAPATH-ID-4="0000000000000004"
#DATAPATH-ID-5="0000000000000005"


for ovs in ${Switches} ; do
		echo "Adding OVS bridge ${OVS_BRIDGE} on ${ovs}"

		ssh  ${ovs} "${CMD1}"
		ssh  ${ovs} "${CMD2}"

		if [ $ovs == "128.104.159.147" ]; then
			echo "1"
			ETHARRAY=( "eth1" "eth2" "eth3" "eth4")
			DATAPATHID="0000000000000001"
		fi
		if [ $ovs == "128.104.159.148" ]; then
			echo "2"
			ETHARRAY=( "eth1" "eth2" "eth3" "eth4")
			DATAPATHID="0000000000000002"
		fi
		if [ $ovs == "128.104.159.149" ]; then
			echo "3"
			ETHARRAY=( "eth1" "eth2" "eth3" "eth4")
			DATAPATHID="0000000000000003"
		fi
		# if [ $ovs == "204.76.187.82" ]; then
		# 	echo "4"
		# 	ETHARRAY=("eth1" "eth2" "eth3")
		#	DATAPATH-ID="0000000000000004"
		# fi
		# if [ $ovs == "204.76.187.83" ]; then
		# 	echo "5"
		# 	ETHARRAY=("eth1" "eth2" "eth3")
		#	DATAPATH-ID="0000000000000005"
		# fi

		echo "add ${#ETHARRAY[@]} ports onto ovs bridge"

		for i in ${ETHARRAY[@]} ; do
			ssh ${ovs} "sudo ovs-vsctl add-port ${OVS_BRIDGE} $i"
		done
		  CMD6="sudo ovs-vsctl set bridge ${OVS_BRIDGE} other-config:datapath-id=${DATAPATHID}"
		  CMD8="sudo ovs-ofctl show ${OVS_BRIDGE} -O openflow13"

		  ssh  ${ovs} "${CMD3}"
		  ssh  ${ovs} "${CMD4}"
		  ssh  ${ovs} "${CMD5}"
		  ssh  ${ovs} "${CMD6}"
		  ssh  ${ovs} "${CMD7}"
		  ssh  ${ovs} "${CMD8}"
	 	echo -e "\n"
done

