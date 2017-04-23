clear; close all;

dataPath='/Volumes/Project/fMRI/Dataset/';       % Path for the dataset
controlPath=[dataPath 'ds171_R1.0.0_control/'];  % Path for the Control group
MDDPath=[dataPath 'ds171_R1.0.0_MDD/'];          % Path for the MDD group
conds={'tonesCon' ; 'emoCon' ; 'PvsNconM' ; 'PvsNconNM' ; 'MvsNMcon' ; 'PvsNcon'};

%% Create model specifications and estimate

% for condInd=1:size(conds,1)
%     
%     % Create job file for 'Specify first level'
%     fid=fopen(['MDD_GLM_' conds{condInd} '.m'],'w');
%     fprintf(fid,['matlabbatch{1}.spm.stats.factorial_design.dir = {''' MDDPath 'MGroupStats_' conds{condInd} '''};']);
%     fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = {\n');
%     for subIndex=1:19
%         
%         if subIndex<10, subNum=['0' num2str(subIndex)];
%         else, subNum=['' num2str(subIndex)];
%         end
%         
%         fprintf(fid,['''' MDDPath 'sub-mdd' subNum '/SSModel/con_000' num2str(condInd) '.nii''\n']);                                                        
%     end
%     fprintf(fid,'};');
%     fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.cov = struct(''c'', {}, ''cname'', {}, ''iCFI'', {}, ''iCC'', {});');
%     fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct(''files'', {}, ''iCFI'', {}, ''iCC'', {});');
%     fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;');
%     fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;');
%     fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.masking.em = {''''};');
%     fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;');
%     fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;');
%     fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;');
%     fclose(fid);
% 
%     % Run job file for 'Specify first level'
%     jobfile = {['MDD_GLM_' conds{condInd} '.m']};
%     inputs = cell(0, 1);
%     spm('defaults', 'FMRI');
%     spm_jobman('run', jobfile, inputs{:});
% 
%     % Create job file for estimate
%     fid=fopen(['MDD_GLMestimate_' conds{condInd} '.m'],'w');
%     fprintf(fid,['matlabbatch{1}.spm.stats.fmri_est.spmmat = {''' MDDPath 'MGroupStats_' conds{condInd} '/SPM.mat''};']);
%     fprintf(fid,'matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;');
%     fprintf(fid,'matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;');
%     fclose(fid);
% 
%     % Run job file for estimate
%     jobfile = {['MDD_GLMestimate_' conds{condInd} '.m']};
%     inputs = cell(0, 1);
%     spm('defaults', 'FMRI');
%     spm_jobman('run', jobfile, inputs{:});
% 
% end
% 

for condInd=1:size(conds,1)
    
    % Create job file for 'Specify first level'
    fid=fopen(['control_GLM_' conds{condInd} '.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.factorial_design.dir = {''' controlPath 'CGroupStats_' conds{condInd} '''};']);
    fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = {\n');
    for subIndex=1:20
        
        if subIndex<10, subNum=['0' num2str(subIndex)];
        else, subNum=['' num2str(subIndex)];
        end
        
        fprintf(fid,['''' controlPath 'sub-control' subNum '/SSModel/con_000' num2str(condInd) '.nii''\n']);                                                        
    end
    fprintf(fid,'};');
    fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.cov = struct(''c'', {}, ''cname'', {}, ''iCFI'', {}, ''iCC'', {});');
    fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct(''files'', {}, ''iCFI'', {}, ''iCC'', {});');
    fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;');
    fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;');
    fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.masking.em = {''''};');
    fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;');
    fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;');
    fprintf(fid,'matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;');
    fclose(fid);

    % Run job file for 'Specify first level'
    jobfile = {['control_GLM_' conds{condInd} '.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});

    % Create job file for estimate
    fid=fopen(['control_GLMestimate_' conds{condInd} '.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.fmri_est.spmmat = {''' controlPath 'CGroupStats_' conds{condInd} '/SPM.mat''};']);
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;');
    fprintf(fid,'matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;');
    fclose(fid);

    % Run job file for estimate
    jobfile = {['control_GLMestimate_' conds{condInd} '.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});

end

