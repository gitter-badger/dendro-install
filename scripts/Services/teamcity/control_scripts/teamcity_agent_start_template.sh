#!/usr/bin/env bash

#teamcity
teamcity_agent_installation_path='%TEAMCITY_AGENT_INSTALLATION_PATH%'
teamcity_agent_log_file='%TEAMCITY_AGENT_LOG_FILE%'

"$teamcity_agent_installation_path/bin/agent.sh start >> $teamcity_agent_log_file 2>&1"
