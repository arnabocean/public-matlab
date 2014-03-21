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
%	Other m-files required: getCWT.m, removeCommons_BaseFilename.m.
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
%	Version:		1.1
%	Last Revised:	Mon Mar 17 18:08:34 2014
%
%	Changelog:
%
%		Updated to include removeCommons_BaseFilename implementation.

if nargin == 0
	ext = '*.bsl.txt';
	flag = 1;
elseif nargin == 1 and strcmp(lower(ext),'plb')
	disp('Running only PLB Files.');
	filename = onlyPLBFiles;
	flag = 0;
elseif nargin == 1
	flag = 1;
elseif nargin == 2
	filename = removeCommons_BaseFilename(ext,tstExt);
	flag = 0;
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

scalestart = 10;
scaleinc = 20;
scaleend = 500;

cwtnum = 1;
scales = scalestart(cwtnum): scaleinc(cwtnum): scaleend(cwtnum);

%% Parallelize

% if matlabpool('size') == 0
% 	matlabpool open 2;
% end

%% Loop!

parfor kk = 1: szfile(1)
% for kk = 1: szfile(1)

	fprintf('%d\t',kk);
	if mod(kk,10) == 0
		fprintf('\n');
	end

	[~, flname, ~] = fileparts(filename{kk,1});

	in = load(filename{kk,1});
	cw1 = getCWT(in(:,2),scales,wvlt{cwtnum},flname);
	LCCinlineCWTPlot(cw1,scales,wvlt{cwtnum},strcat(flname,'_',wvlt{cwtnum}));
end

% matlabpool close;

%%	Move files into folder

mvfldr = '../BSLCWTMAT';
movefile('*.mat',mvfldr);

%% Clear memory

clearvars
