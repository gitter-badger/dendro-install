#!/usr/bin/env bash

if [ -z ${DIR+x} ]; then
	#running by itself
	source ../../constants.sh
	script_dir=$(get_script_dir)
	running_folder='.'
else
	#running from dendro_full_setup_ubuntu_server_ubuntu_16.sh
	source ./constants.sh
	script_dir=$(get_script_dir)
	running_folder=$script_dir/Dependencies/Redis
fi

setup_dir=$(pwd) && cd $running_folder || "Unable to cd to folder $running_folder while setting up Redis instances."

info "Setting up Redis instances..."

chmod +x ./add_redis_instance.sh

./add_redis_instance.sh $redis_default_id $redis_default_host $redis_default_port $set_dev_mode &&
./add_redis_instance.sh $redis_social_id $redis_social_host $redis_social_port $set_dev_mode &&
./add_redis_instance.sh $redis_notification_id $redis_notification_host $redis_notification_port $set_dev_mode||
  die "Unable to setup Redis instances."
