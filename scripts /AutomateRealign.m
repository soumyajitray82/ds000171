clear; close all;
dataPath='/Volumes/Project/fMRI/Dataset/';       % Path for the dataset
controlPath=[dataPath 'ds171_R1.0.0_control/'];  % Path for the Control group
MDDPath=[dataPath 'ds171_R1.0.0_MDD/'];          % Path for the MDD group

% Realignment for MDD subjects
for subIndex=1:19

    % Set the subject number format
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for realign
    fid=fopen(['MDD' subNum 'realign.m'],'w');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.data = {\n');

    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end
        % Select all the frames
        fprintf(fid,'{\n');
        for frameInd=1:105
            fprintf(fid,['''' MDDPath 'sub-mdd' subNum '/func/sub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii,' num2str(frameInd) '''\n']);
        end
        fprintf(fid,'}\n');
    end
    fprintf(fid,'};\n');

    % Set the parameters for realignment
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '''';\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [0 1];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = ''r'';\n');
    fclose(fid);
    %% Run the job file for realign
    jobfile = {['MDD' subNum 'realign.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});

end

% Realignment for control subjects
for subIndex=11:20

    % Set the subject number format
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for realign
    fid=fopen(['control' subNum 'realign.m'],'w');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.data = {\n');

    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end
        % Select all the frames
        fprintf(fid,'{\n');
        for frameInd=1:105
            fprintf(fid,['''' controlPath 'sub-control' subNum '/func/sub-control' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii,' num2str(frameInd) '''\n']);
        end
        fprintf(fid,'}\n');
    end
    fprintf(fid,'};\n');

    % Set the parameters for realignment
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '''';\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [0 1];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = ''r'';\n');
    fclose(fid);
    %% Run the job file for realign
    jobfile = {['control' subNum 'realign.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});

end