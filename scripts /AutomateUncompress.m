clear; close all;
dataPath='/Volumes/Project/fMRI/Dataset/';
controlPath=[dataPath 'ds171_R1.0.0_control/'];
MDDPath=[dataPath 'ds171_R1.0.0_MDD/'];

for subIndex=1:20
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end
    gunzip([controlPath 'sub-control' subNum '/anat/' '*.gz']);
    gunzip([controlPath 'sub-control' subNum '/func/' '*.gz']);
end

for subIndex=1:19
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end
    gunzip([MDDPath 'sub-MDD' subNum '/anat/' '*.gz']);
    gunzip([MDDPath 'sub-MDD' subNum '/func/' '*.gz']);
end