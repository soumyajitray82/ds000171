clear; close all;

dataPath='/Volumes/Project/fMRI/Dataset/';       % Path for the dataset
controlPath=[dataPath 'ds171_R1.0.0_control/'];  % Path for the Control group
MDDPath=[dataPath 'ds171_R1.0.0_MDD/'];          % Path for the MDD group

%% Create condition strings
z='';
for i=1:54
    z=[z ' 0'];
end
v=num2str(1/5);
tonesCon=['0' z(1:5) v z(1:19) v z(1:19) v z(1:19) v z(1:19) v z(1:22)];
v=num2str(1/10);
emoCon=[v ' ' v z(1:17) v ' ' v z(1:17) v ' ' v z(1:17) v ' ' v z(1:17) v ' ' v z(1:26)];
vp=num2str(1/3);vn=num2str(-1/3);
PvsNconM=[vn ' ' vp z(1:17) vn ' ' vp z(1:17) vn ' ' vp z(1:66)];
vp=num2str(1/2);vn=num2str(-1/2);
PvsNconNM=['0' z(1:58) vn ' ' vp z(1:17) vn ' ' vp z(1:26)];
vp=num2str(1/6);vn=num2str(-1/4);
MvsNMcon=[vp ' ' vp z(1:17) vp ' ' vp z(1:17) vp ' ' vp z(1:17) vn ' ' vn z(1:17) vn ' ' vn z(1:26)];
vp=num2str(1/6);vn=num2str(-1/6);
PvsNcon=[vn ' ' vp z(1:17) vn ' ' vp z(1:17) vn ' ' vp z(1:17) vn ' ' vp z(1:17) vn ' ' vp z(1:26)];

%% Contrasts for MDD subjects
for subIndex=1:19
     % Set the subject number format - 01 etc
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end
    
    %% Create the job file for contrasts for SSM
    fid=fopen(['MDD_' subNum '_SSM_contrasts.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.spmmat = {''' MDDPath 'sub-mdd' subNum '/SSModel/SPM.mat''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = ''tones'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [' tonesCon '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = ''emotional'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [' emoCon '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = ''PosVsNegMusical'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = [' PvsNconM '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = ''PosVsNegNonMusical'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = [' PvsNconNM '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = ''MusicalvsNonMusical'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = [' MvsNMcon '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = ''PosVsNeg'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = [' PvsNcon '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.delete = 1;\n');
    fclose(fid);
    
    %% Run the job file for contrasts for SSM
    jobfile = {['MDD_' subNum '_SSM_contrasts.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
end

% Contrasts for control subjects
for subIndex=1:20
     % Set the subject number format - 01 etc
    if subIndex<10, subNum=['0' num2str(subIndex)];
    else, subNum=['' num2str(subIndex)];
    end
    
    %% Create the job file for contrasts for SSM
    fid=fopen(['control_' subNum '_SSM_contrasts.m'],'w');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.spmmat = {''' controlPath 'sub-control' subNum '/SSModel/SPM.mat''};\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = ''tones'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [' tonesCon '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = ''emotional'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [' emoCon '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = ''PosVsNegMusical'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = [' PvsNconM '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = ''PosVsNegNonMusical'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = [' PvsNconNM '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = ''MusicalvsNonMusical'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = [' MvsNMcon '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = ''PosVsNeg'';\n');
    fprintf(fid,['matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = [' PvsNcon '];\n']);
    fprintf(fid,'matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = ''none'';\n');
    fprintf(fid,'matlabbatch{1}.spm.stats.con.delete = 1;\n');
    fclose(fid);
    
    %% Run the job file for contrasts for SSM
    jobfile = {['control_' subNum '_SSM_contrasts.m']};
    inputs = cell(0, 1);
    spm('defaults', 'FMRI');
    spm_jobman('run', jobfile, inputs{:});
    
end