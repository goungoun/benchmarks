#!/bin/bash

FRAMEWORK=$1
SPLICEHDFS=$2

# TODO: better usage and help

if [[ "$FRAMEWORK" == "" || "$SPLICEHDFS" == "" ]]; then
  echo "Error: we need two arguments!"
  exit 1
fi

# TODO: generate these lists automagicaly from dcos api

# TODO: complete the looping and make these vars
#declare -i COUNT=0
#declare -a PODS
#declare -a NAMES
#declare -a IPS
# PODS => dcos splicedb --name=$FRAMEWORK pods list
# COUNT++

# TODO: implement getPods
# getPods() {
#   local framework=$1
#}

# TODO: implement getNameFromTask
# getNameFromTask() {
#  local task=$1
# dcos ... task exec -ti $task bash -c hostname
# }

pods=( "hmaster-0" "hmaster-1" "hregion-0" "hregion-1" "hregion-2" "hregion-3" "zookeeper-0" "zookeeper-1" "zookeeper-2")
names=( "hmaster-0-node.${FRAMEWORK}.mesos" \
	"hmaster-1-node.${FRAMEWORK}.mesos" \
	"hregion-0-node.${FRAMEWORK}.mesos" \
	"hregion-1-node.${FRAMEWORK}.mesos" \
	"hregion-2-node.${FRAMEWORK}.mesos" \
	"hregion-3-node.${FRAMEWORK}.mesos" \
	"data-0-node.${SPLICEHDFS}.mesos" \
	"data-1-node.${SPLICEHDFS}.mesos" \
	"data-2-node.${SPLICEHDFS}.mesos" \
	"data-3-node.${SPLICEHDFS}.mesos" )

echo "Debug: pod-0 ${pods[0]} names-0 ${names[0]}"

# =====
# Subroutines

findTask() {
  local pod=$1
  #echo "task-for-$pod"
  dcos splicedb --name=$FRAMEWORK pods info $pod | \
  jq -r '.[0].status.taskId.value'
}

fetchIpFromTask() {
  local name=$1
  local task=$2

  #echo "debug: fetching name $name from task $task" 
  local ip=$(dcos task exec -ti $task bash -c "host $name" | awk '{print $4}')

  # TODO: put ip in IPS[num]  
  echo $ip
}

pushDNS() {
  local task=$1
  local file=$2

  echo push DNS $file to $task
  cat $file | dcos task exec -i $task bash -c "cat >> /etc/hosts"
}

# ====
# Main

DNS="./temp-DNS.txt"

touch $DNS
if [[ ! -f $DNS ]]; then
  echo Error: problem making temp file $DNS
  exit 2
fi

hmasterTask=$(findTask ${pods[0]})

echo "found hmasterTask $hmasterTask"

# loop through pods getting dns
declare -i i=0
for pod in ${pods[@]}; do
  echo "get ip for name ${names[$i]} using $hmasterTask"
  ip=$(fetchIpFromTask ${names[$i]} $hmasterTask | sed -e "s/
  echo -e "$ip\t\t${names[$i]}"  >> $DNS
  let i++
done

echo DNS made
cat $DNS
echo -e "\n"

# loop through pods, pushing DNS to tasks
for pod in ${pods[@]}; do
  echo "push dns to pod ${pod[0]}"
  task=$(findTask $pod)
  #echo pushing etc hosts on $pod via task $task
  pushDNS $task $DNS
done

#cleanup
#rm $DNS