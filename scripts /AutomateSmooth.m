clear; close all;
dataPath='/Volumes/Project/fMRI/Dataset/';       % Path for the dataset
controlPath=[dataPath 'ds171_R1.0.0_control/'];  % Path for the Control group
MDDPath=[dataPath 'ds171_R1.0.0_MDD/'];          % Path for the MDD group

% Smooth for MDD subjects
for subIndex=1:19
    % Set the subject number format - 01 etc
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end
    %% Create the job file for smooth
    fid=fopen(['MDD' subNum 'smooth.m'],'w');
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.data = {\n');
    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end
        % Select all the frames
        for frameInd=1:105
            fprintf(fid,['''' MDDPath 'sub-mdd' subNum '/func/wsub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii,' num2str(frameInd) '''\n']);
        end
    end
    fprintf(fid,'};\n');
     % Set the parameters for smooth
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.fwhm = [8 8 8];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.dtype = 0;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.im = 0;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.prefix = ''s'';\n');
    fclose(fid);
    %% Run the job file for smooth
    jobfile = {['MDD' subNum 'smooth.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
end

% Smooth for control subjects
for subIndex=1:20
    % Set the subject number format - 01 etc
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end
    %% Create the job file for smooth
    fid=fopen(['control' subNum 'smooth.m'],'w');
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.data = {\n');
    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end
        % Select all the frames
        for frameInd=1:105
            fprintf(fid,['''' controlPath 'sub-control' subNum '/func/wsub-control' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii,' num2str(frameInd) '''\n']);
        end
    end
    fprintf(fid,'};\n');
     % Set the parameters for smooth
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.fwhm = [8 8 8];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.dtype = 0;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.im = 0;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.smooth.prefix = ''s'';\n');
    fclose(fid);
    %% Run the job file for smooth
    jobfile = {['control' subNum 'smooth.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
end