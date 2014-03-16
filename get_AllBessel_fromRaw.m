function get_AllBessel_fromRaw(ext)


%	get_AllBessel_fromRaw. Perform a Bessel filter operation
%	    on raw data, and save to disk.
%
%	Inputs:
%
%			- ext:	String, to search the current directory
%					for files to analyze. eg.: '*.raw.txt'.
%
%	Outputs:
%
%			- Filtered data is written to disk with the suffix
%			  .bsl.txt.
%
%	Other m-files required: getBessel.m.
%	Sub-functions required: None.
%	MAT-files required: None.
%
%	See also: get_AllFFT_fromRaw.m.	


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.0
%	Last Revised:	Mon Mar 10 13:58:25 2014
%
%	Changelog:
%
%		

if nargin == 0
	ext = '*.raw.txt';
end

%% Find Files

files = dir(fullfile(ext));
filename = {files(:).name}';

clear files;

szfile = size(filename);

%% Bessel

% Bessel Variables
order = 4;
low = 50*10^3;		%	50kHz;
high = 1000*10^3;	%	1000kHz = 1MHz;
sampling = 25*10^6;	%	25MHz;

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
	dat1 = getBessel(in,flname,order,low,high,sampling);
end

% matlabpool close;

%%	Move files into folder

mvfldr = '../bsldata';
movefile('*.bsl.txt',mvfldr);

%% Clear memory

clearvars
