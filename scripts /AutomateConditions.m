clear; close all;

dataPath='/Volumes/Project/fMRI/Dataset/';       % Path for the dataset
controlPath=[dataPath 'ds171_R1.0.0_control/'];  % Path for the Control group
MDDPath=[dataPath 'ds171_R1.0.0_MDD/'];          % Path for the MDD group

%% Create conditions for MDD subjects
for subInd=1:19
    
    if subInd<10, subNum=['0' num2str(subInd)];
    else, subNum=['' num2str(subInd)];
    end
    
    
    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end

        % Path for conditions tsv file for the particular subject and run
        filePath=[MDDPath 'sub-mdd' subNum '/func/sub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_events.tsv'];
        
        % Path for output file for the conditions 
        oFilePath=[MDDPath 'sub-mdd' subNum '/func/sub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_events.mat'];
        
        % Path for storing the unique events in a text file
        eventFilePath=[MDDPath 'sub-mdd' subNum '/func/sub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_events.txt'];
        
        % Read the linebisection tsv file containing conditions data
        fid=fopen(filePath,'r');
        fileData=textscan(fid, '%f %f %s' ,'HeaderLines',1,'Delimiter',' ');
        fclose(fid);
        
        % Extract lists of event labels, times and durations
        eventLabels=char(fileData{1,3});
        times=fileData{1,1};
        taskDur=fileData{1,2};
        
        % Identify unique events
        uniqueEvents=unique(eventLabels,'rows');

        % Initialize output variables to be written to the file
        names=cell(1,size(uniqueEvents,1));
        onsets=cell(1,size(uniqueEvents,1));
        durations=cell(1,size(uniqueEvents,1));
        
        % Create times and duration list for each unique event
        % Store the unique event labels in a file
        fid=fopen(eventFilePath,'w');
        for eventInd=1:size(uniqueEvents,1)
            fprintf(fid,[uniqueEvents(eventInd,:) '\n']);
            names{eventInd}=uniqueEvents(eventInd,:);
            onsets{eventInd}=[];
            durations{eventInd}=[];
            
            for timeInd=1:size(fileData{1,1},1)
                if eventLabels(timeInd,:)==uniqueEvents(eventInd,:)
                    onsets{eventInd}=[onsets{eventInd} times(timeInd)];
                    durations{eventInd}=[durations{eventInd} taskDur(timeInd)];
                end
            end
        end
        fclose(fid);
        
        % Create the conditions file 
        save(oFilePath,'names','onsets','durations');
        
    end
end

%% Create conditions for Control subjects
for subInd=1:20
    
    if subInd<10, subNum=['0' num2str(subInd)];
    else, subNum=['' num2str(subInd)];
    end
    
    
    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end

        % Path for conditions tsv file for the particular subject and run
        filePath=[controlPath 'sub-control' subNum '/func/sub-control' subNum '_task-' type '_run-' num2str(runInd) '_events.tsv'];
        
        % Path for output file for the conditions 
        oFilePath=[controlPath 'sub-control' subNum '/func/sub-control' subNum '_task-' type '_run-' num2str(runInd) '_events.mat'];
        
        % Path for storing the unique events in a text file
        eventFilePath=[controlPath 'sub-control' subNum '/func/sub-control' subNum '_task-' type '_run-' num2str(runInd) '_events.txt'];
        
        % Read the linebisection tsv file containing conditions data
        fid=fopen(filePath,'r');
        fileData=textscan(fid, '%f %f %s' ,'HeaderLines',1,'Delimiter',' ');
        fclose(fid);
        
        % Extract lists of event labels, times and durations
        eventLabels=char(fileData{1,3});
        times=fileData{1,1};
        taskDur=fileData{1,2};
        
        % Identify unique events
        uniqueEvents=unique(eventLabels,'rows');

        % Initialize output variables to be written to the file
        names=cell(1,size(uniqueEvents,1));
        onsets=cell(1,size(uniqueEvents,1));
        durations=cell(1,size(uniqueEvents,1));
        
        % Create times and duration list for each unique event
        % Store the unique event labels in a file
        fid=fopen(eventFilePath,'w');
        for eventInd=1:size(uniqueEvents,1)
            fprintf(fid,[uniqueEvents(eventInd,:) '\n']);
            names{eventInd}=uniqueEvents(eventInd,:);
            onsets{eventInd}=[];
            durations{eventInd}=[];
            
            for timeInd=1:size(fileData{1,1},1)
                if eventLabels(timeInd,:)==uniqueEvents(eventInd,:)
                    onsets{eventInd}=[onsets{eventInd} times(timeInd)];
                    durations{eventInd}=[durations{eventInd} taskDur(timeInd)];
                end
            end
        end
        fclose(fid);
        
        % Create the conditions file 
        save(oFilePath,'names','onsets','durations');
        
    end
end