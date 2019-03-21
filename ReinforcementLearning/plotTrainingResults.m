% Plot reinforcement learning training results given filename
% Copyright 2019 The MathWorks, Inc.
function plotTrainingResults

%% Interactively load file
close all
filename = uigetfile;
load(filename)

%% Episode reward plot
figure(1), hold on
plot(trainingResults.EpisodeReward,'bo-');
plot(trainingResults.AverageReward,'r*-');
plot(trainingResults.EpisodeQ0,'gx--');
legend('Episode Reward','Average Reward','Initial Episode Value (Q0)','Location','NorthWest');
title('Episode Training Plot')
xlabel('Episode Number')

%% Average steps over time
figure(2), hold on
plot(trainingResults.EpisodeSteps,'bo-');
plot(trainingResults.TotalAgentSteps./(1:numel(trainingResults.EpisodeSteps))','r*-');
legend('Episode Steps','Average Steps','Location','NorthWest');
title('Average Steps Plot') 
xlabel('Episode Number')
ylabel('Average Steps')

%% Episode reward plot vs. steps
figure(3), hold on
plot(trainingResults.TotalAgentSteps,trainingResults.EpisodeReward,'bo-');
plot(trainingResults.TotalAgentSteps,trainingResults.AverageReward,'r*-');
plot(trainingResults.TotalAgentSteps,trainingResults.EpisodeQ0,'gx--');
legend('Episode Reward','Average Reward','Initial Episode Value (Q0)','Location','NorthWest');
title('Step Training Plot')
xlabel('Total Steps')