# Walking Robots -- Control Design
### Copyright 2019 The MathWorks, Inc.

These files demonstrate 3D walking control for a bipedal humanoid robot.

Requires MATLAB R2018a or later.

## MAIN FOLDER

* `walkingRobot3DPath.slx` -- Simulink model showing the full 3D control. This robot has different parameters 
compared to the original example, to show the robustness of this control with a 
more realistic robot (thinner torso, smaller feet, less world damping, etc.). 
This uses the `robotParameters3D.m` data file.

* `plotWalkingTraj.m` -- MATLAB script that takes logged data from the previous model and animates the 
trajectory for the torso and the feet.

* `walkingRobot3DMPC.slx` -- Simulink model showing the full 3D control with a trajectory generated using
Model Predictive Control (MPC).

## MPCHUMANOID FOLDER
Contains utility files for the MPC trajectory generation example.

* `designMPCWalkingPatternGen.mlx` -- Live Script showing how to design the MPC Controllers for stable walking patterns.

* `testMPCWalkingPatternGen.slx` -- Simple linear inverted pendulum model to test the generated trajectories.

## INVERSEKINEMATICS FOLDER
Contains utilities and examples for leg inverse kinematics, which are used by the main control design and reinforcement learning models.

* `calculateInvKin.mlx` -- This Live Script is used to derive an analytical expression to compute leg 
inverse kinematics in the longitudinal/sagittal direction. It generates a MATLAB function named `legInvKin.m`.

* `animateFootGait.m` -- Script that animates the walking gait according to the specified parameters, and 
tests the inverse kinematics calculation above.

* `walkingRobotFootPlace.slx` -- Simulink model showing how to create virtual joints at the foot to directly
actuate the motion of each foot according to a specified stepping plan.

* `walkingRobotInvKin.slx` -- Simulink model showing how to integrate the inverse kinematics and step planners
from the previous files. 

* `robotParametersInvKin.m` -- Parameter file loaded automatically with the above example models.