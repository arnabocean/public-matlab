function get_AllCWT_fromBessel(ext, tstExt)


%	get_AllCWT_fromBessel. Compute Continuous Wavelet Transform
%	    on filtered data, and save result to disk.
%
%	Inputs:
%
%			- ext:	String, to search the current directory
%					for files to analyze. eg.: '*.bsl.txt'.
%
%	Outputs:
%
%			- Filtered data is written to disk as .mat data files.
%
%	Other m-files required: getCWT.m, removeCommons.m.
%	Sub-functions required: None.
%	MAT-files required: None.
%
%	See also: get_AllBessel_fromRaw.m.	


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.2
%	Last Revised:	Mon Sep 15 15:12:23 2014
%
%	Changelog:
%
%		Updated to include removeCommons_BaseFilename implementation.
%	    Updated to remove reference to removeCommons_BaseFilename.m; instead use NEW removeCommons implementation as removeCommons(ext, TstExt, 1);

%%	Arguments check

if nargin == 2
	filename = removeCommons(ext,tstExt,1);
	
	flag = 0;	%	No need to search directory for file list
elseif nargin == 1 && strcmp(lower(ext),'plb')
	disp('Running only PLB Files.');
	filename = onlyPLBFiles;
	
	flag = 0;	%	No need to search directory for file list
elseif nargin == 1
	
	flag = 1;	%	Yes, need to search directory for file list
elseif nargin == 0
	ext = '*.bsl.txt';
	
	flag = 1;	%	No need to search directory for file list
end

%% Find Files (only if flag == 1)

if flag == 1
	files = dir(fullfile(ext));
	filename = {files(:).name}';

	clear files;
end
clear flag;


szfile = size(filename);
disp(szfile);

%% CWT parameters

% scalestart = [5; 1; 10];
% % scaleinc = [5; 5; 5];	% 20
% scaleinc = [50; 50; 50];	% 20
% scaleend = [1500; 1500; 1750];
% wvlt = {'morl'; 'mexh'; 'meyr'};

%	Below was used for v2 of CWT processing.
% scalestart = 10;
% scaleinc = 20;
% scaleend = 500;
% scales = scalestart(cwtnum): scaleinc(cwtnum): scaleend(cwtnum);


cwtnum = 1;
wvlt = {'morl'};
% scales = [20, 25, 29, 34, 39, 43, 48, 54, 63, 74, 90, 116, 163, 271, 406, 813];
% scales = [33.2992, 35.6360, 38.3255, 41.4541, 45.1389, 49.5427, 54.8986, 61.5530, 70.0431, 81.2500, 96.7262, 119.4853, 156.2500, 225.6944, 406.2500];
% scales = [33.85417, 36.93182, 40.62500, 45.13889, 50.78125, 58.03571, 67.70833, 81.25000, 101.56250, 135.41667, 203.12500, 406.25000];
scales = [38.3254716981132, 42.3177083333333, 48.3630952380952, 56.4236111111111, 65.5241935483871, 75.2314814814815, 92.3295454545455, 119.485294117647, 169.270833333333, 290.178571428571, 507.812500000000, 1354.16666666667];

%% Parallelize

% if matlabpool('size') == 0
% 	matlabpool open 2;
% end

%% Loop!

parfor kk = 1: szfile(1)
% for kk = 1: szfile(1)

	% fprintf('%d\t',kk);
	% if mod(kk,10) == 0
	% 	fprintf('\n');
	% end

	[~, flname, ~] = fileparts(filename{kk,1});

	in = load(filename{kk,1});
	cw1 = getCWT(in(:,2),scales,wvlt{cwtnum},flname);
	LCCinlineCWTPlot(cw1,scales,wvlt{cwtnum},strcat(flname,'_',wvlt{cwtnum}));
end

% matlabpool close;

%%	Move files into folder

mvfldr = '../RAWCWTMAT';
movefile('*.mat',mvfldr);

movefile('*.png','../RAWCWTPNG');

%% Clear memory

clearvars
