# Meeting 1-7-2016

## Project Progress

### Member contributions

#### Carlos

Learned basic hardware integration by connecting a Qt project with Arduino and Beaglebone boards

#### Maria

Implemented a moveable 3d model in Gazebo, working on integration with C++ for dynamic commanding

#### Jacky

Learned Qt front-end navigation and use of Dialogs

#### Claudia

Learned Qt front-end navigation and Qt's JavaScript callbacks, implemented UI components

#### Tyler

Learned Qt front-end, integrated OpenCV and UDP communication in a Qt project

### Project Status

* Barebones integration of libraries and communication
* Most UI screens scaffolded
* Basic concurrency working properly

### Next Steps

* Carlos - Integrate a *remote* Ubuntu/ROS node to communicate with Ground, build OpenCV functionality
* Claudia - Build additional UI components, dynamic JS-driven sensor widgets
* Jacky - Scaffold and populate rest of UI, design/build user experience
* Maria - Integrate Gazebo simulation with our Qt GUI backend
* Tyler - Work with all to integrate widgets, Gazebo, and OpenCV components/functions

### Major Goals for First Iteration

* External camera feed detects and tracks objects
* External ROS node executes movement commands
* Animated graphics and status displays dynamically render according to incoming data
* Intuitive user-experience ie fluid transistions between application states, easy-to-understand controls