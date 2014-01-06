function getRawFFT(ext)


%	getRawFFT. Function to extract raw data and perform FFT
%	           analysis on a set of data files from disk, and
%	           write output data to disk. 
%
%	Function to extract raw data from data exported by Gagescope, 
%	then compute the FFT of each data record, and finally write
%	these data (raw and FFT) back to disk.
%	
%	This program uses the parallel computing toolbox in MATLAB. 
%	For this purpose, each step of the loop has been created as 
%	a separate function:
%
%		1.	extractRaw.m inputs a filename, extracts the raw data, 
%			and writes to disk.
%		2.	getFFT.m inputs raw data and filename, creates FFT, 
%			and writes to disk.	
%	
%	Inputs:
%
%			- ext: string to find data files to work on. 
%	               Default value is set to '*.sig', which is
%	               what I personally encounter most.
%
%	Outputs:
%
%			- Data is output to disk, in separate folders.
%	          ./rawdata => extracted time-amplitude data
%	          ./fftdata => FFT data: frequency-amplitude
%
%	Other m-files required: extractRaw.m, getFFT.m.
%	Sub-functions required: None.
%	MAT-files required: None.
%
%	See also: extractRaw.m, getFFT.m.


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.1
%	Last Revised:	Tue Dec 24 02:13:28 2013
%
%	Changelog:
%
%		Updated documentation.
%	    Added comments and sections to code

%% Initialize

if ~exist('ext','var')
	var = '*.sig';
end


%%	Get list of files

files = dir(fullfile(ext));

for i = 1: length(files)

    filename{i,1} = files(i,1).name;
end

clear files;

szfile = size(filename);

%%	Setup parallel processing

% if matlabpool('size') == 0
% 	matlabpool open 2;
% end

%%	Parallel for loop

% parfor i = 1: szfile(1)
for i = 1: szfile(1)

	%%	display counter
	if mod(i,10) == 1
		fprintf('%d\t',i);
	end

	%%	Call each function by turn
	filestr = filename{i,1};
	in = extractRaw(filestr);
	dat1 = getFFT(in,filestr);
end

%%
% matlabpool close;

%%
movefile('*.raw.txt','./rawdata');
movefile('*.fft.txt','./fftdata');

%%
clearvars

