clear; close all;
dataPath='/Volumes/Project/fMRI/Dataset/';       % Path for the dataset
controlPath=[dataPath 'ds171_R1.0.0_control/'];  % Path for the Control group
MDDPath=[dataPath ''];                           % Path for the MDD group
SPMPath='/Users/soumyajitray/Documents/Spring2017/FunctionalNeuroimaging/spm12/';  % SPM Path
MDDSub=1:19;                                      % MDD Subject Selection
ControlSub=1:20;                                   % Control Subject Selection 

%% Preprocessing
disp('Start Realignment');                                      % Realign functional images
AutomateRealign(controlPath,MDDPath,MDDSub,ControlSub);

disp('Start Coregistration');                                   % Coregister images
AutomateCoregistration(controlPath,MDDPath,MDDSub,ControlSub);

disp('Start Segmentation');                                     % Segment images
AutomateSegment(controlPath,MDDPath,SPMPath,MDDSub,ControlSub);

disp('Start Normalization');                                    % Normalize images
AutomateNormalize(controlPath,MDDPath,MDDSub,ControlSub);

disp('Start Smooth');                                           % Smooth images
AutomateSmooth(controlPath,MDDPath,MDDSub,ControlSub);

%% Modeling 
disp('Start create conditions');                                % Create conditions.mat with multiple conditions
AutomateConditions(controlPath,MDDPath,MDDSub,ControlSub);

disp('Start Single Subject Modeling and Estimation');           % Create Single Subject Modeling and Estimation
AutomateSSM(controlPath,MDDPath,MDDSub,ControlSub);

disp('Start creating contrasts for Single Subject Modeling');   % Create Single Subject Model contrasts
AutomateSSMContrasts(controlPath,MDDPath,MDDSub,ControlSub);


