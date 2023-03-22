# Walking Robot Examples
### Copyright 2017-2019 The MathWorks, Inc.

This repository contains example files for the following [MATLAB and Simulink Robotics Arena](https://www.mathworks.com/academia/student-competitions/tutorials-videos.html) videos on walking robots.

* [Modeling and simulation](https://www.mathworks.com/videos/modeling-and-simulation-of-walking-robots-1576560207573.html)
* [Actuation and control](https://www.mathworks.com/videos/matlab-and-simulink-robotics-arena-modeling-pneumatic-robot-actuators-part-1-1542190287608.html)
* [Trajectory optimization](https://www.mathworks.com/videos/matlab-and-simulink-robotics-arena-walking-robots-part-3-trajectory-optimization-1506440520726.html)
* [Walking pattern generation](https://www.mathworks.com/videos/matlab-and-simulink-robotics-arena-walking-robots-pattern-generation-1546434170253.html)
* [Deep reinforcement learning](https://www.mathworks.com/videos/deep-reinforcement-learning-for-walking-robots--1551449152203.html)

You can also learn more about this example from [our blog post](https://blogs.mathworks.com/racing-lounge/2017/10/11/walking-robot-modeling-and-simulation).

For any questions, email us at roboticsarena@mathworks.com.

## Setup
Run `startupWalkingRobot.m` to get the MATLAB path ready

There are 4 main folders containing the various walking robot examples

1. `ModelingSimulation` -- Shows how to build the simulation of the walking 
robot, including contact forces, various actuator models, and importing from CAD.

2. `Optimization` -- Shows how to use genetic algorithms to optimize joint angle
trajectories for stability and speed.

3. `ControlDesign` -- Shows how to create closed-loop walking controllers 
using common techniques like Zero Moment Point (ZMP) manipulation and 
Model Predictive Control (MPC) for pattern generation.

4. `ReinforcementLearning` -- Shows how to set up and train a Deep Deterministic 
Policy Gradient (DDPG) reinforcement learning agent for learning how to walk.

Each of these folders has its own separate README with more information.

---

## Multiphysics and Contact Libraries
For convenience, local copies of the Simscape Multibody Multiphysics Library and
Simscape Multibody Contact Forces Library have been included with this submission. 
If you would like to install the latest version of these libraries, you can find
them from the Add-On Explorer, or on the File Exchange

* Simscape Multibody Multiphysics Library: https://www.mathworks.com/matlabcentral/fileexchange/37636-simscape-multibody-multiphysics-library
* Simscape Multibody Contact Forces Library: https://www.mathworks.com/matlabcentral/fileexchange/47417-simscape-multibody-contact-forces-library

