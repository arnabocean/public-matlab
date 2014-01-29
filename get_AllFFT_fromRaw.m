function get_AllFFT_fromRaw(ext,besselTrue)


%	get_AllFFT_fromRaw. Perform FFT on a set of files, 
%	    optionally performing a Bessel filter operation
%	    on the raw data before doing FFT.
%
%	Inputs:
%
%			- ext:	String, to search the current directory
%					for files to analyze. eg.: '*.raw.txt'.
%			- besselTrue: 0 or 1. Whether Bessel filtering
%						  should be performed before FFT.
%						  Default value is 0 (No Bessel).
%
%	Outputs:
%
%			- FFT data is written to disk with the suffix
%			  .fft.txt.
%
%	Other m-files required: getBessel.m, getFFT.m.
%	Sub-functions required: None.
%	MAT-files required: None.
%
%	See also: plotFFTsets.m.	


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.0
%	Last Revised:	Wed Jan 29 11:29:46 2014
%
%	Changelog:
%
%		





if ~exist('besselTrue','var')
	besselTrue = 0;
end

%% Find Files

files = dir(fullfile(ext));
filename = {files(:).name}';

clear files;

szfile = size(filename);

%% Bessel

if besselTrue == 1
	% Bessel Variables
	order = 4;
	low = 50*10^3;		%	50kHz;
	high = 1000*10^3;	%	1000kHz = 1MHz;
	sampling = 25*10^6;	%	25MHz;
end

%% Parallelize

% if matlabpool('size') == 0
% 	matlabpool open 2;
% end

%% Loop!

% parfor kk = 1: szfile(1)
for kk = 1: szfile(1)

	fprintf('%d\t',kk);
	if mod(kk,10) == 0
		fprintf('\n');
	end

	% in = extractRaw(filename{kk,1});
	in = load(filename{kk,1});

	if besselTrue == 1
		in = getBessel(in,'',order,low,high,sampling);
	end

	dat1 = getFFT(in,filename{kk,1});
end

% matlabpool close;

%%	Move files into folder

if besselTrue == 1
	mvfldr = './bslfftdata';
else
	mvfldr = './fftdata';
end

movefile('*.fft.txt',mvfldr);

%% Clear memory

clearvars
