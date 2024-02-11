# The Kautham Project Docker

The Kautham Project is a software tool developed at the [Service and Industrial Robotics (SIR)](http://robotics.upc.edu/) group of the [Institute of Industrial and Control Engineering (IOC)](https://ioc.upc.edu/en/the-institute) of the [Universitat Politècnica de Catalunya (UPC)](https://www.upc.edu/en), for teaching and research in robot motion planning.

The tool allows to cope with problems with one or more robots, being a generic robot defined as a kinematic tree with a mobile base, i.e. the tool can plan and simulate from simple two degrees of freedom free-flying robots to multi-robot scenarios with mobile manipulators equipped with anthropomorphic hands. The main core of planners is provided by the [Open Motion Planning Library (OMPL)](http://ompl.kavrakilab.org/).

Different basic planners can be flexibly used and parameterized, allowing students to gain insight into the different planning algorithms. Among the advanced features the tool allows to easily define the coupling between degrees of freedom, the dynamic simulation and the integration with task planners. It is principally being used in the research of motion planning strategies for dexterous dual arm robotic systems.

## Why Docker?

This repository contains a docker based in Ubuntu 22 and ROS 2 Humble. It already has all the dependencies and files needed to run Kautham software out of the box.

The idea of this project is to simplify the installation process and provide a more simple tool to use it.

It is already setup with many utilities so you will feel like everything is installed natively, but with the confidance that if at any moment something stops working, you just need to stop the container and open a new one.

## Pre-Installation

It is necessary to generate an access token in your Github profile. To do this, go to Settings, in the left hand options list, select the Developer settings. Dropdown the "Personal access tokens" option on the left and select "Tokens (classic)".

There create a token checking the following options:
-  write:packages
    - read:packages

Select No expiration date, and copy the generated token in a safe place, because you will not be able to see it later.

## Installation

The Kautham Docker has been created and configured specifically to allow the user to interact and develop easily. But it is necessary to meet some requirements in the pc:

- Nvidia GPU
- Ubuntu 20 or higher
- minimum 6Gb RAM, recomended 8Gb.

The installation is automatized with the bash file provided in this repo. It will install the docker engine, the Nvidia container runtime and some other dependencies. During the installation some popups will show up. The first one will request sudo access (Ubuntu Username and Password).

After some installation it will ask your Github Username and the Token you generated before. After that, Docekr will be linked with Github containers, like the Kautham one.

Finally, the script will ask for a name for your docker and the ling of the docker image you want to install, use this image link:  
```ghcr.io/sergimuac/upc_humble:kautham```

After the intallation it is needed to reboot the computer.

If all the installation was successful, open a new terminal and type the docker name you set during the installation, this will attach the docker in the current terminal. To work easily, run ```terminator -u``` and start using the new terminal.

## NOTE:

The default docker user is "user" and the sudo apssword is "user".
The "exchange" folder in your home directory is shared with your PC, so use it to share files.
The Kautham colcon workspace is in /home folder.
Remember to source "/opt/ros/humble/setup.bash" to enable ROS features.