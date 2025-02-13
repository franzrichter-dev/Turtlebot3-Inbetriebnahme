#!/bin/bash

sudo echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo apt-get update
sudo apt-get upgrade
wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_kinetic.sh
chmod 755 ./install_ros_kinetic.sh 
bash ./install_ros_kinetic.sh

sudo apt-get install ros-kinetic-joy ros-kinetic-teleop-twist-joy \
  ros-kinetic-teleop-twist-keyboard ros-kinetic-laser-proc \
  ros-kinetic-rgbd-launch ros-kinetic-rosserial-arduino \
  ros-kinetic-rosserial-python ros-kinetic-rosserial-client \
  ros-kinetic-rosserial-msgs ros-kinetic-amcl ros-kinetic-map-server \
  ros-kinetic-move-base ros-kinetic-urdf ros-kinetic-xacro \
  ros-kinetic-compressed-image-transport ros-kinetic-rqt* ros-kinetic-rviz \
  ros-kinetic-gmapping ros-kinetic-navigation ros-kinetic-interactive-markers

sudo apt install ros-kinetic-dynamixel-sdk
sudo apt install ros-kinetic-turtlebot3-msgs
sudo apt install ros-kinetic-turtlebot3

rm -rf ./install_ros_kinetic.sh

sudo apt install python3-roslaunch
