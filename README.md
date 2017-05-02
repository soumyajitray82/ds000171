# ds000171
https://openfmri.org/dataset/ds000171/

Neural Processing of Emotional Musical and Nonmusical Stimuli in Depression

Openfmri Dataset ds000171: Scripts for preprocessing and modelling. These Matlab scripts require SPM 12 software to be installed. Each script creates batch files and runs them using SPM's inbuilt batch file execution. 

AutomateDS171.m - Main script to access all other functions below. Except group modeling scripts. 

AutomateRename.m - Rename files to a standard format

AutomateRealign.m - Realign functional images

AutomateCoregistration.m - Register functional with T1

AutomateSegment.m - Segment images

AutomateNormalize.m - Normalization of all functional images

AutomateSmooth.m - Smooth the images

AutomateConditions.m - Create the conditions files (events onsets and durations)

AutomateSSM.m - Single Subject Modelling

AutomateSSMContrasts.m - Create contrasts for Single Subject Model

AutomateGLM.m - Group level modelling

AutomateGLMContrasts.m - Create contrasts for Group Level Model

