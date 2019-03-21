# Walking Robots -- Reinforcement Learning
### Copyright 2019 The MathWorks, Inc.

Contains files for reinforcement learning of the walking robot simulation.

Requires MATLAB R2019a or later.

## 2D (6-DOF) MODEL FILES
This robot has 3 degrees of freedom per leg, and can only move legs along the longitudinal direction.

* `walkingRobotRL2D.slx` -- Reinforcement learning capable model
* `createWalkingAgent2D.m` -- Reinforcement agent creation and training script

## 3D (10-DOF) MODEL FILES
This robot has 5 degrees of freedom per leg, which allows it to take lateral steps as well.

* `walkingRobotRL3D.slx` -- Reinforcement learning capable model
* `createWalkingAgent3D.m` -- Reinforcement agent creation and training script

## COMMON FILES
* `createDDPGNetworks.m` -- Creates actor and critic neural networks and reinforcement learning representations
* `createDDPGOptions.m` -- Creates training options for reinforcement learning
* `robotParametersRL.m` -- Parameter file automatically loaded on model startup
* `walkerResetFcn.m` -- Utility function to set initial conditions randomly for exploration
* `walkerInvKin.m` -- Inverse kinematics utility function to help set initial conditions
* `plotTrainingResults.m` -- Plots the reinforcement learning training results from a given saved MAT-file
* `savedAgents` folder -- Contains presaved agents and training results

NOTE: If you are running one of the models without first training an agent, 
you should load one of the presaved agents from the `savedAgents` folder.