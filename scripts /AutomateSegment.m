function AutomateSegment(controlPath,MDDPath,SPMPath,MDDSub,ControlSub)

%% Automate segment for MDD subjects
for subIndex=MDDSub

    % Set the subject number format
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for segment
    fid=fopen(['MDD' subNum 'segment.m'],'w');
    
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.channel.vols = {''' MDDPath 'sub-mdd' subNum '/anat/sub-mdd' subNum '_T1w.nii,1''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.channel.write = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {''' SPMPath 'tpm/TPM.nii,1''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {''' SPMPath 'tpm/TPM.nii,2''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {''' SPMPath 'tpm/TPM.nii,3''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {''' SPMPath 'tpm/TPM.nii,4''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {''' SPMPath 'tpm/TPM.nii,5''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {''' SPMPath 'tpm/TPM.nii,6''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.affreg = ''mni'';\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.write = [0 1];\n');
    fclose(fid);
    
     %% Run the job file for segment
    jobfile = {['MDD' subNum 'segment.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
end

%% Automate segment for Control subjects
for subIndex=ControlSub

    % Set the subject number format
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for segment
    fid=fopen(['control' subNum 'segment.m'],'w');
    
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.channel.vols = {''' controlPath 'sub-control' subNum '/anat/sub-control' subNum '_T1w.nii,1''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.channel.write = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {''' SPMPath 'tpm/TPM.nii,1''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {''' SPMPath 'tpm/TPM.nii,2''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {''' SPMPath 'tpm/TPM.nii,3''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {''' SPMPath 'tpm/TPM.nii,4''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {''' SPMPath 'tpm/TPM.nii,5''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [1 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];\n');
    fprintf(fid,['matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {''' SPMPath 'tpm/TPM.nii,6''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.affreg = ''mni'';\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.preproc.warp.write = [0 1];\n');
    fclose(fid);
    
     %% Run the job file for segment
    jobfile = {['control' subNum 'segment.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
end

end