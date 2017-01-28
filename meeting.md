# Meeting Points

## Progress this week

* All team members successfully installed Ubuntu, ROS, Gazebo, OpenCV
* Reached out to Robotics online community for existing solutions to Gazebo/ROS navigation
* Integrated animated graph into project
* Heavy research & experimentation with hardware and third-party solutions

## Challenges Encountered

### Gazebo Navigation

#### Key functions of autonomous navigation

* Localization - where am I?
* Mapping - where is everythine else?
* Planning - Given my goal, location, and environment, what are my next moves?

#### Existing Navigation Solutions

* Linear trajectory calculation is straightforward, but no working examples due to lack of ut: only useful for trivial case where locality and map are already known
* Popular algorithms: SPLAM (Simultaneuous Planning, Localization, and Mapping) and SLAM (same, without planning)
* Most existing solutions developed for mature versions of ROS

## Plans for Initial Demo

* Demonstrate two-way communication between Gazebo/ROS component and Qt client
* Demonstrate hardware integrations Camera->OpenCV, and Beaglebone/Arduino->

## Division of Labor

* Maria - Topics, Services, Publishers, Subscribers for all relevant sensors
* Carlos - Hardware integration, OpenCV object tracking
* Jacky - ROS Navigation Research, UAS Docs and Guide with Tyler
* Cluadia - Man-machine interface refinement