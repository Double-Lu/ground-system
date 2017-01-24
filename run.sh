#!/bin/bash

roscore &
sleep 7
rosrun gazebo_ros gazebo &
sleep 10
rosrun gazebo_ros spawn_model -database coke_can -gazebo -model coke_can -y 1
sleep 2
rostopic pub -r 20 /gazebo/set_model_state gazebo_msgs/ModelState '{model_name: coke_can, pose: { position: { x: 1, y: 0, z: 2 }, orientation: {x: 0, y: 0.491983115673, z: 0, w: 0.870604813099 } }, twist: { linear: { x: 0, y: 0, z: 0 }, angular: { x: 0, y: 0, z: 0}  }, reference_frame: world }' &

rosrun gazebo_ros spawn_model -database quadrotor -gazebo -model quadrotor -y 1
cd UASDrone
roslaunch uas_turtle start_turtle.launch &
cd ..
./UASGroundSystem/UASGroundSystem