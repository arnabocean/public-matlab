function get_AllCWT_fromBessel(ext)


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
%	Other m-files required: getCWT.m.
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
%	Version:		1.0
%	Last Revised:	Sun Mar 16 19:55:10 2014
%
%	Changelog:
%
%		

if nargin == 0
	ext = '*.bsl.txt';
end

%% Find Files

files = dir(fullfile(ext));
filename = {files(:).name}';

clear files;

szfile = size(filename);

%% CWT parameters

scalestart = [5; 1; 10];
scaleinc = [5; 5; 5];	% 20
scaleend = [1500; 1500; 1750];
wvlt = {'morl'; 'mexh'; 'meyr'};

cwtnum = 1;
scales = scalestart(kk): scaleinc(kk): scaleend(kk);

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
end

% matlabpool close;

%%	Move files into folder

mvfldr = '../CWTMAT';
movefile('*.mat',mvfldr);

%% Clear memory

clearvars
