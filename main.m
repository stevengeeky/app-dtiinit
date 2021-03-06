function [] = main()

switch getenv('ENV')
case 'IUHPC'
    disp('loading paths (HPC)')
    addpath(genpath('/N/u/hayashis/BigRed2/git/vistasoft'))
    addpath(genpath('/N/u/hayashis/BigRed2/git/jsonlab'))
case 'VM'
    disp('loading paths (VM)')
    addpath(genpath('/usr/local/vistasoft'))
    addpath(genpath('/usr/local/jsonlab'))
end

% load my own config.json
config = loadjson('config.json');

% to find resolution
dwi = niftiRead(config.dwi);
res = dwi.pixdim(1:3);
clear dwi

dwParams = dtiInitParams;
dwParams.clobber           =  1;
dwParams.eddyCorrect       = -1;
dwParams.phaseEncodeDir    = 2; 
dwParams.rotateBvecsWithRx = 0;
dwParams.rotateBvecsWithCanXform = 0;
dwParams.bvecsFile  = config.bvecs;
dwParams.bvalsFile  = config.bvals;
dwParams.dt6BaseName = 'dti_trilin';
dwParams.outDir     = pwd;
dwParams.dwOutMm    = res;

%apply config params
if isprop(config, 'eddyCorrect')
	dwParams.eddyCorrect = config.eddyCorrect;
end

dwParams.outDir = './';

dtiInit(config.dwi, config.t1, dwParams)

