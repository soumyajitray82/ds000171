clear;close all;
dataPath='/Volumes/Project/fMRI/Dataset/';
controlPath=[dataPath 'ds171_R1.0.0_control/'];
MDDPath=[dataPath 'ds171_R1.0.0_MDD/'];

%% MDD subjects file rename
for subIndex=1:20
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end
    % Get all nii files in the current folder
    subPath=[MDDPath 'sub-MDD' subNum '/func/'];
    files = dir([subPath '*.tsv']);
    
    incorrectOrder=0;
    for id = 1:length(files)
        f=files(id).name;
        if ~isempty(strfind(f,'-music')) && (~isempty(strfind(f,'run-4')) || ~isempty(strfind(f,'run-5')))
            incorrectOrder=1;
        end
    end
    
    if(incorrectOrder==1) 
         for id = 1:length(files)
             f=files(id).name;
             if ~isempty(strfind(f,'-music'))
                if ~isempty(strfind(f,'run-3')) 
                    newName=strrep(f,'run-3','run-1');
                    movefile([subPath f],[subPath newName]);
                end
                if ~isempty(strfind(f,'run-4'))
                    newName=strrep(f,'run-4','run-2');
                    movefile([subPath f],[subPath newName]);
                end
                if ~isempty(strfind(f,'run-5'))
                    newName=strrep(f,'run-5','run-3');
                    movefile([subPath f],[subPath newName]);
                end
            end
            if ~isempty(strfind(f,'-nonmusic'))
                if ~isempty(strfind(f,'run-1'))
                    newName=strrep(f,'run-1','run-4');
                    movefile([subPath f],[subPath newName]);
                end
                if ~isempty(strfind(f,'run-2'))
                    newName=strrep(f,'run-2','run-5');
                    movefile([subPath f],[subPath newName]);
                end
            end
         end
    end
end

% Control subjects file rename
for subIndex=1:20
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end
    % Get all nii files in the current folder
    subPath=[controlPath 'sub-control' subNum '/func/'];
    files = dir([subPath '*.tsv']);
    
    incorrectOrder=0;
    for id = 1:length(files)
        f=files(id).name;
        if ~isempty(strfind(f,'-music')) && (~isempty(strfind(f,'run-4')) || ~isempty(strfind(f,'run-5')))
            incorrectOrder=1;
        end
    end
    
    if(incorrectOrder==1) 
         for id = 1:length(files)
             f=files(id).name;
             if ~isempty(strfind(f,'-music'))
                if ~isempty(strfind(f,'run-3')) 
                    newName=strrep(f,'run-3','run-1');
                    movefile([subPath f],[subPath newName]);
                end
                if ~isempty(strfind(f,'run-4'))
                    newName=strrep(f,'run-4','run-2');
                    movefile([subPath f],[subPath newName]);
                end
                if ~isempty(strfind(f,'run-5'))
                    newName=strrep(f,'run-5','run-3');
                    movefile([subPath f],[subPath newName]);
                end
            end
            if ~isempty(strfind(f,'-nonmusic'))
                if ~isempty(strfind(f,'run-1'))
                    newName=strrep(f,'run-1','run-4');
                    movefile([subPath f],[subPath newName]);
                end
                if ~isempty(strfind(f,'run-2'))
                    newName=strrep(f,'run-2','run-5');
                    movefile([subPath f],[subPath newName]);
                end
            end
         end
    end
end


