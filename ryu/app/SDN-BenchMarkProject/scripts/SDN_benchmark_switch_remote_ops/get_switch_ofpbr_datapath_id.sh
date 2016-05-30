#!/bin/bash
#USERNAME=szb53
Switches="128.104.159.147 128.104.159.148 128.104.159.149"
OVS_BR=ofpbr
# change to OFP_SWITCHES_LIST=`pwd`/../../network-data/ofp_switches_list.db
# if you run this script in stand-alone mode
#echo "./scripts/remote_ovs_operation_topo_2/get_switch_ofpbr_datapath_id.sh"
OFP_SWITCHES_LIST="/users/szb53/ryu-controller1/ryu_openflow-master/ryu/app/SDN-BenchMarkProject/network-data2/ofp_switches_list.db"
#echo "writing to ${OFP_SWITCHES_LIST}"
if [ '${OFP_SWITCHES_LIST}' ]; then
    # echo "File Exist"
    echo -e 'Warning: '
    rm  ${OFP_SWITCHES_LIST}
    # echo "deleted"
fi

if [ ! -e ${OFP_SWITCHES_LIST} ]; then
    # echo "Create new file"
    touch ${OFP_SWITCHES_LIST}
fi

CMD1="hostname"
CMD2="sudo ovs-ofctl show ${OVS_BR} -O Openflow13"
for ovs in ${Switches} ; do
   H=`ssh  ${ovs} ${CMD1}`
   DPID=`ssh  ${ovs} ${CMD2}`
   H=`echo ${H} | awk -F. '{print $1}'`
   DPID=`echo ${DPID} | grep dpid | awk -F: '{print $3}'`
   DPID=`echo ${DPID} | awk '{print $1}'`
   #echo ${H} ${DPID}
   echo ${H} ${DPID} >> ${OFP_SWITCHES_LIST}
  
   
done
echo -e "File is save at: ${OFP_SWITCHES_LIST}"
echo -e "Switch hostname and Hex dataapath ID"
cat ${OFP_SWITCHES_LIST}
# echo "Switch List updated "