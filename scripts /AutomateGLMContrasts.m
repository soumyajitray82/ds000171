clear; close all;

dataPath='/Volumes/Project/fMRI/Dataset/';       % Path for the dataset
controlPath=[dataPath 'ds171_R1.0.0_control/'];  % Path for the Control group
MDDPath=[dataPath 'ds171_R1.0.0_MDD/'];          % Path for the MDD group
conds={'tonesCon' ; 'emoCon' ; 'PvsNconM' ; 'PvsNconNM' ; 'MvsNMcon' ; 'PvsNcon'};

% GLM Contrasts for MDD subjects
for condIndex=1:6

    %% Create the job file for contrasts for GLM
    fid=fopen(['MDD_' conds{condIndex} '_contrasts.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.spmmat = {''' MDDPath 'MGroupStats_' conds{condIndex} '/SPM.mat''};\n']);
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = ''' conds{condIndex} ''';\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1];\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.delete = 1;\n');
    fclose(fid);
    
    %% Run the job file for contrasts for GLM
    jobfile = {['MDD_' conds{condIndex} '_contrasts.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
end

% GLM Contrasts for control subjects
for condIndex=1:6

    %% Create the job file for contrasts for GLM
    fid=fopen(['control_' conds{condIndex} '_contrasts.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.spmmat = {''' controlPath 'CGroupStats_' conds{condIndex} '/SPM.mat''};\n']);
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = ''' conds{condIndex} ''';\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1];\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.delete = 1;\n');
    fclose(fid);
    
    %% Run the job file for contrasts for GLM
    jobfile = {['control_' conds{condIndex} '_contrasts.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
end