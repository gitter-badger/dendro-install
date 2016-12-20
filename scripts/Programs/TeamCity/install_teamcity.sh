#!/usr/bin/env bash

if [ -z ${DIR+x} ]; then
	#running by itself
	source ../../constants.sh
else
	#running from dendro_full_setup_ubuntu_server_ubuntu_16.sh
	source ./constants.sh
fi

#save current dir
setup_dir=$(pwd) &&

info "Installing TeamCity by JetBrains..."

#install oracle jdk 8
source ./Dependencies/oracle_jdk8.sh &&

#create dendro user
source ./Programs/create_dendro_user.sh &&

#install TeamCity
sudo rm -rf ./TeamCity-10.0.3.tar.gz*
#sudo wget --progress=bar:force https://download.jetbrains.com/teamcity/TeamCity-10.0.3.tar.gz || die "Unable to download TeamCity."
sudo wget --progress=bar:force http://10.0.2.3/TeamCity-10.0.3.tar.gz || die "Unable to download TeamCity."
tar xfz TeamCity-10.0.3.tar.gz || die "Unable to extract TeamCity package"
sudo rm -rf $teamcity_installation_path
sudo mkdir -p $teamcity_installation_path
sudo mv TeamCity/* $teamcity_installation_path
replace_text_in_file 	"$teamcity_installation_path/conf/server.xml" \
											'<Connector port="8111" protocol="org.apache.coyote.http11.Http11NioProtocol"' \
											'<Connector port="3001" protocol="org.apache.coyote.http11.Http11NioProtocol"' \
											'teamcity_patch_dendro_build_server_port'
sudo chown -R $dendro_user_name $teamcity_installation_path
sudo chmod -R ug+w $teamcity_installation_path


info "Setting up TeamCity service...\n"

#save current dir
setup_dir=$(pwd)

#stop current recommender service if present
info "Stopping $teamcity_service_name service..."
sudo systemctl stop $teamcity_service_name

#setup auto-start teamcity service
sudo rm -rf $teamcity_startup_item_file
sudo touch $teamcity_startup_item_file

#create pids folder...
sudo mkdir -p $installation_path/service_pids

printf "Teamcity Running Service Command:"
printf "\n"
printf "/bin/sh -c '$teamcity_installation_path/bin/teamcity-server.sh start >> ${teamcity_log_file} 2>&1'"
printf "\n"

#create teamcity log file
sudo touch $teamcity_log_file
sudo chmod ugo+r $teamcity_log_file
sudo chown $dendro_user_name $teamcity_log_file
sudo chmod 0777 $teamcity_startup_item_file

sudo sed -e "s;%DENDRO_USERNAME%;$dendro_user_name;g" \
				 -e "s;%TEAMCITY_INSTALLATION_PATH%;$teamcity_installation_path;g" \
				 -e "s;%TEAMCITY_SERVICE_NAME%;$teamcity_service_name;g" \
				 -e "s;%TEAMCITY_STARTUP_ITEM_FILE%;$teamcity_startup_item_file;g" \
				 -e "s;%TEAMCITY_LOG_FILE%;$teamcity_log_file;g" \
				 ./Services/TeamCity/teamcity-template.sh | tee $teamcity_startup_item_file

sudo chmod 0755 $teamcity_startup_item_file
sudo update-rc.d $teamcity_service_name enable
sudo $teamcity_startup_item_file start && success "TeamCity service successfully installed." || die "Unable to install TeamCity service."

#go back to initial dir
cd $setup_dir || die "Unable to return to starting directory during TeamCity Setup."
