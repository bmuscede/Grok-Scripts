#!/bin/bash

# Argument check.
if [ $# -ne 2 ]; then
	echo "ROS Feature Interaction Hotspot Detector"
	echo "Usage: RunScripts.sh [ROS_MODEL] [OBFUSCATED/REGULAR]"
	echo ""
	echo "This runs all the scripts in the children directories. Type OBFUSCATED for"
	echo "obfuscated results and REGULAR for regular ID resolved results."
	exit 1
fi

# Starts setting variables.
MODEL=$1
TYPE=$2
FILE=`pwd`
MODE="Regular"

# Performs argument checking.
if [ "$TYPE" == "OBFUSCATED" ]; then
	FILE="$FILE/Obfuscated"
	MODE="Obfuscated"
elif [ "$TYPE" == "REGULAR" ]; then
	FILE="$FILE/Regular"
else
	echo "Error: Either type REGULAR or OBFUSCATED for the second argument!"
	echo "Usage: RunScripts.sh [ROS_MODEL] [OBFUSCATED/REGULAR]"
	exit 1
fi
if [ ! -f $MODEL ]; then
        echo "Error: Please supply a valid ROS TA model for analysis!"
	echo "Usage: RunScripts.sh [ROS_MODEL] [OBFUSCATED/REGULAR]"
	exit 1
fi

# Lets the user know the operation.
echo "###############################################################"
echo "# Checking for Feature Interaction Hotspots"
echo "#"
echo "# Mode: $MODE"
echo "###############################################################"
echo

# Now loops through to execute.
for F in "$FILE"/*
do
	# Indicates which we are working with.
	echo "${F##*/} Hotspots:"
	echo

	for HS in "$F"/*
	do
		ql $HS $MODEL
	done

	echo "###############################################################"
done
