clear; close all;

dataPath='/Volumes/Project/fMRI/Dataset/';       % Path for the dataset
controlPath=[dataPath 'ds171_R1.0.0_control/'];  % Path for the Control group
MDDPath=[dataPath 'ds171_R1.0.0_MDD/'];          % Path for the MDD group

% SSM for MDD subjects
for subIndex=1:19

    % Set the subject number format - 01 etc
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for SSM
    fid=fopen(['MDD_' subNum '_SSM.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.dir = {''' MDDPath 'sub-mdd' subNum '/SSModel''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.timing.units = ''secs'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2.3;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;\n');
    
    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end
        
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').scans = {\n']);
        niftiObject=nifti([MDDPath 'sub-mdd' subNum '/func/swsub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii']);  % Obtain nifti object of image
        imageMatrix=niftiObject.dat(:,:,:,:);
        
        % Select all the frames
        for frameInd=1:size(imageMatrix,4)
            fprintf(fid,['''' MDDPath 'sub-mdd' subNum '/func/swsub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii,' num2str(frameInd) '''\n']);
        end
        fprintf(fid,'};\n');
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').cond = struct(''name'', {}, ''onset'', {}, ''duration'', {}, ''tmod'', {}, ''pmod'', {}, ''orth'', {});\n']);
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').multi = {''' MDDPath 'sub-mdd' subNum '/func/sub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_events.mat''};\n']);
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').regress = struct(''name'', {}, ''val'', {});\n']);
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').multi_reg = {''' MDDPath 'sub-mdd' subNum '/func/rp_sub-mdd' subNum '_task-' type '_run-' num2str(runInd) '_bold.txt''};\n']);
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').hpf = 128;\n']);
    end
    
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.fact = struct(''name'', {}, ''levels'', {});\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.volt = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.global = ''None'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.mask = {''''};\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.cvi = ''AR(1)'';\n');
    fclose(fid);
    
     %% Run the job file for SSM
    jobfile = {['MDD_' subNum '_SSM.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
     %% Create the job file for Estimate SSM
    fid=fopen(['MDD_' subNum '_SSMestimate.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.fmri_est.spmmat = {''' MDDPath 'sub-mdd' subNum '/SSModel/SPM.mat''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;\n');
    fclose(fid);
    
    %% Run the job file for Estimate SSM
    jobfile = {['MDD_' subNum '_SSMestimate.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
    
end


% SSM for control subjects
for subIndex=1:20

    % Set the subject number format - 01 etc
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for SSM
    fid=fopen(['control_' subNum '_SSM.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.dir = {''' controlPath 'sub-control' subNum '/SSModel''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.timing.units = ''secs'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2.3;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;\n');
    
    for runInd=1:5
        %Set the stimulus type - music or nonmusic - dependent on the run
        if runInd<4, type='music';
        else, type='nonmusic';
        end
        
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').scans = {\n']);
        
        niftiObject=nifti([controlPath 'sub-control' subNum '/func/swsub-control' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii']);  % Obtain nifti object of image
        imageMatrix=niftiObject.dat(:,:,:,:);

        % Select all the frames
        for frameInd=1:size(imageMatrix,4)
            fprintf(fid,['''' controlPath 'sub-control' subNum '/func/swsub-control' subNum '_task-' type '_run-' num2str(runInd) '_bold.nii,' num2str(frameInd) '''\n']);
        end
        fprintf(fid,'};\n');
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').cond = struct(''name'', {}, ''onset'', {}, ''duration'', {}, ''tmod'', {}, ''pmod'', {}, ''orth'', {});\n']);
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').multi = {''' controlPath 'sub-control' subNum '/func/sub-control' subNum '_task-' type '_run-' num2str(runInd) '_events.mat''};\n']);
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').regress = struct(''name'', {}, ''val'', {});\n']);
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').multi_reg = {''' controlPath 'sub-control' subNum '/func/rp_sub-control' subNum '_task-' type '_run-' num2str(runInd) '_bold.txt''};\n']);
        fprintf(fid,['matlabbatch{1}.spm.stats.fmri_spec.sess(' num2str(runInd) ').hpf = 128;\n']);
    end
    
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.fact = struct(''name'', {}, ''levels'', {});\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.volt = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.global = ''None'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.mask = {''''};\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_spec.cvi = ''AR(1)'';\n');
    fclose(fid);
    
     %% Run the job file for SSM
    jobfile = {['control_' subNum '_SSM.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
     %% Create the job file for Estimate SSM
    fid=fopen(['control_' subNum '_SSMestimate.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.fmri_est.spmmat = {''' controlPath 'sub-control' subNum '/SSModel/SPM.mat''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;\n');
    fclose(fid);
    
    %% Run the job file for Estimate SSM
    jobfile = {['control_' subNum '_SSMestimate.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
end

