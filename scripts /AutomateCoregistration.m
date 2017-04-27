function AutomateCoregistration(controlPath,MDDPath,MDDSub,ControlSub)

%% Coregistration for MDD subjects
for subIndex=MDDSub

    % Set the subject number format
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for coregister
    fid=fopen(['MDD' subNum 'coregister.m'],'w');
    fprintf(fid,'spm_figure(''GetWin'',''Graphics'');');
    fprintf(fid,['matlabbatch{1}.spm.spatial.coreg.estimate.ref = {''' MDDPath 'sub-mdd' subNum '/func/meansub-mdd' subNum '_task-music_run-1_bold.nii,1''};\n']);
    fprintf(fid,['matlabbatch{1}.spm.spatial.coreg.estimate.source = {''' MDDPath 'sub-mdd' subNum '/anat/sub-mdd' subNum '_T1w.nii,1''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.other = {''''};\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = ''nmi'';\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];');
    fclose(fid);
    
     %% Run the job file for coregister
    jobfile = {['MDD' subNum 'coregister.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
end

%% Coregistration for control subjects
for subIndex=ControlSub

    % Set the subject number format
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end

    %% Create the job file for coregister
    fid=fopen(['control' subNum 'coregister.m'],'w');
    fprintf(fid,'spm_figure(''GetWin'',''Graphics'');');
    fprintf(fid,['matlabbatch{1}.spm.spatial.coreg.estimate.ref = {''' controlPath 'sub-control' subNum '/func/meansub-control' subNum '_task-music_run-1_bold.nii,1''};\n']);
    fprintf(fid,['matlabbatch{1}.spm.spatial.coreg.estimate.source = {''' controlPath 'sub-control' subNum '/anat/sub-control' subNum '_T1w.nii,1''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.other = {''''};\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = ''nmi'';\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];\n');
    fprintf(fid,'matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];');
    fclose(fid);
    
     %% Run the job file for coregister
    jobfile = {['control' subNum 'coregister.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
end

end