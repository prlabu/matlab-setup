% %------------ FreeSurfer -----------------------------%
% fshome = getenv('FREESURFER_HOME');
% fsmatlab = sprintf('%s/matlab',fshome);
% if (exist(fsmatlab) == 7)
%     addpath(genpath(fsmatlab));
% end
% clear fshome fsmatlab;
% %-----------------------------------------------------%
% 
% %------------ FreeSurfer FAST ------------------------%
% fsfasthome = getenv('FSFAST_HOME');
% fsfasttoolbox = sprintf('%s/toolbox',fsfasthome);
% if (exist(fsfasttoolbox) == 7)
%     path(path,fsfasttoolbox);
% end
% clear fsfasthome fsfasttoolbox;
% %-----------------------------------------------------%


% set defulat 
datetime.setDefaultFormats('defaultdate','yyyyMMdd');

set(0,'defaultAxesFontSize', 20);
set(0,'defaultfigurecolor',[1 1 1]);

set(0, 'DefaultFigureRenderer', 'painters');

set(groot, 'defaultAxesTickLabelInterpreter','none'); 
set(groot, 'defaultLegendInterpreter','none');
% 
% % addpath(genpath('/Volumes/Sector4/Users/Latane/std_latane'));
% 
% environment_setup();
% 
% % 
% paths.project = '/Volumes/Sector4/Users/Latane/scrambled-nonsense/code';
% fprintf('Project path: %s\n', paths.project);
% 
% % unclear why MATLAB is not adding the images toolbox - but here's a
% % quickfix
% addpath(genpath('/Applications/MATLAB_R2021a.app/toolbox/images'));






