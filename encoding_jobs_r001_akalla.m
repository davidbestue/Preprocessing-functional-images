%-----------------------------------------------------------------------
% Job saved on 26-Jun-2018 09:52:06 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%%

%I have to apply the same preprocessing steps in the images of this runs
Runs={'run6', 'run7', 'run8', 'run9', 'run10', 'run11', 'run12', 'run13', 'run14'};

% I am generating one batch for each run. I am appending this batches in the cell Jobs. 
% At the end I will run all the batches inside Jobs
Jobs = {};

%Change the images in each run
for r = 1:length(Runs)
    
    % 1. Realign
    % Load the data of the run (in this case, both the name and dimension of the image are the same in each run)
    matlabbatch{1}.spm.spatial.realign.estwrite.data = {{}};
    for i = 1:180
         matlabbatch{1}.spm.spatial.realign.estwrite.data{1}{end+1}= ['/data/davsan/Desktop/Distractor_project/imaging/r001/encoding_mapping/', Runs{r} , '/fmri3_Encoding_Ax.nii,',sprintf('%i',i)]; 
    end
    matlabbatch{1}.spm.spatial.realign.estwrite.data{1} = transpose(matlabbatch{1}.spm.spatial.realign.estwrite.data{1});
    %%
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.quality = 0.9;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.sep = 4;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.fwhm = 5;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.rtm = 1;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.interp = 2;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.weight = '';
    
    % 2. Slice timing
    matlabbatch{2}.spm.temporal.st.scans{1}(1) = cfg_dep('Realign: Estimate: Realigned Images (Sess 1)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','cfiles'));
    matlabbatch{2}.spm.temporal.st.nslices = 47;
    matlabbatch{2}.spm.temporal.st.tr = 2.335;
    matlabbatch{2}.spm.temporal.st.ta = 2.2853;
    matlabbatch{2}.spm.temporal.st.so = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46];
    matlabbatch{2}.spm.temporal.st.refslice = 23;
    matlabbatch{2}.spm.temporal.st.prefix = 'c';
    
    %Corregister: Estimate to the structural
    matlabbatch{3}.spm.spatial.coreg.estimate.ref = {'/data/davsan/Desktop/Distractor_project/imaging/r001/structural/struct_1/Sag_T1w3D_BRAVO.nii,1'};    matlabbatch{3}.spm.spatial.coreg.estimate.source(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
    matlabbatch{3}.spm.spatial.coreg.estimate.other(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
    matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
    
    %Corregister: Estimae and Reslice to the template image
    matlabbatch{4}.spm.spatial.coreg.estwrite.ref = {'/data/davsan/Desktop/Distractor_project/imaging/r001/encoding_mapping/template/template.nii,1'};
    matlabbatch{4}.spm.spatial.coreg.estwrite.source(1) = cfg_dep('Coregister: Estimate: Coregistered Images', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','cfiles'));
    matlabbatch{4}.spm.spatial.coreg.estwrite.other(1) = cfg_dep('Coregister: Estimate: Coregistered Images', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','cfiles'));
    matlabbatch{4}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
    matlabbatch{4}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
    matlabbatch{4}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{4}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
    matlabbatch{4}.spm.spatial.coreg.estwrite.roptions.interp = 4;
    matlabbatch{4}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{4}.spm.spatial.coreg.estwrite.roptions.mask = 0;
    matlabbatch{4}.spm.spatial.coreg.estwrite.roptions.prefix = 'o';
    
    %Smooth
    matlabbatch{5}.spm.spatial.smooth.data(1) = cfg_dep('Coregister: Estimate & Reslice: Resliced Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rfiles'));
    matlabbatch{5}.spm.spatial.smooth.fwhm = [4 4 4];
    matlabbatch{5}.spm.spatial.smooth.dtype = 0;
    matlabbatch{5}.spm.spatial.smooth.im = 0;
    matlabbatch{5}.spm.spatial.smooth.prefix = 'n';

    Jobs{end+1} = matlabbatch;
end

%Run the batches inside Jobs
spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',Jobs); 

%Important output: nocfmri3_Encoding_Ax.nii in each session

