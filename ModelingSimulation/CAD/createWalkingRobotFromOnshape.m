% Import walking robot CAD model from Onshape
% Copyright 2017 The MathWorks, Inc.

%% Setup
% Flag to create a new model or only a new data file
createNewModel = false;
% Change to the CAD folder so files get generated there
cadFolder = fileparts(mfilename('fullpath'));
cd(cadFolder);

%% Generate files from Onshape URL
onshapeUrl = 'https://cad.onshape.com/documents/5fe92a55bb0eaf8b1a0ed6c2/w/58d64f59407477ebd625e16e/e/5295d0860871d6a3d51ca630';
xmlFile = smexportonshape(onshapeUrl);

%% Import the CAD model 
if createNewModel
    % Creates new model and data file
    smimport(xmlFile);
else
    % Creates new data file only
    smimport(xmlFile,'ImportMode','dataFile','PriorDataFile','RobotWalker_DataFile')
end