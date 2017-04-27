function AutomateNormalize(controlPath,MDDPath,MDDSub,ControlSub)

%% Normalization for MDD subjects
for subIndex=MDDSub

    % Set the subject number format - 01 etc
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for normalise
    fid=fopen(['MDD' subNum 'normalise.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.spatial.normalise.write.subj.def = {''' MDDPath 'sub-mdd' subNum '/anat/y_sub-mdd' subNum '_T1w.nii''};\n']);
    
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {\n');
    fprintf(fid,['''' MDDPath 'sub-mdd' subNum '/func/meansub-mdd' subNum '_task-music_run-1_bold.nii,1''\n']);
    
    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end
        
        % Select all the frames
        for frameInd=1:105
            fprintf(fid,['''' MDDPath 'sub-mdd' subNum '/func/sub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii,' num2str(frameInd) '''\n']);
        end

    end
    fprintf(fid,'};\n');

     % Set the parameters for normalisation
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70\n');
    fprintf(fid,'78 76 85];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [2 2 2];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = ''w'';\n');
    fclose(fid);

    %% Run the job file for normalisation
    jobfile = {['MDD' subNum 'normalise.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});

end
%}

%% Normalize for control subjects
for subIndex=ControlSub

    % Set the subject number format
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for normalise
    fid=fopen(['control' subNum 'normalise.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.spatial.normalise.write.subj.def = {''' controlPath 'sub-control' subNum '/anat/y_sub-control' subNum '_T1w.nii''};\n']);
    
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {\n');
    fprintf(fid,['''' controlPath 'sub-control' subNum '/func/meansub-control' subNum '_task-music_run-1_bold.nii,1''\n']);

    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end
        
        % Select all the frames
        for frameInd=1:105
            fprintf(fid,['''' controlPath 'sub-control' subNum '/func/sub-control' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii,' num2str(frameInd) '''\n']);
        end
        
    end
    fprintf(fid,'};\n');

    % Set the parameters for normalisation
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70\n');
    fprintf(fid,'78 76 85];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [2 2 2];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = ''w'';\n');
    fclose(fid);
    
    
    %% Run the job file for normalise
    jobfile = {['control' subNum 'normalise.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});

end

end