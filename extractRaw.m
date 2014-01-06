function in = extractRaw(filename)


%	extractRaw. Function to import a single data file and
%				extract data, then write to disk.
%	
%	Specifically, function to convert Gagescope output data 
%	(converted into ASCII mode already) into simple two 
%	column text file. 
%	
%	The idea is for this function to be used in a loop in 
%	another MATLAB script, for example, in getRawFFT.m
%	
%	Note that this will work only with Gagescope output data 
%	(since the importfile12 function is a custom  function). 
%	For other data, replace importfile12 with an appropriate 
%	import function. 
%
%	Inputs:
%
%			- filename: Filename to import.
%
%	Outputs:
%
%			- in: Two column data matrix.
%				  Column 1 => Time (s). 
%				  Column 2 => Signal Amplitude (V).
%
%	Other m-files required: importfile12.m, stripFileString.m
%	Sub-functions required: None.
%	MAT-files required: None.
%
%	See also: importfile12.m, getRawFFT.m, getFFT.m, stripFileString.m
	

%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.1
%	Last Revised:	Mon Dec 23 18:46:41 2013
%
%	Changelog:
%
%		Updated documentation.

%%	Import Data
[vars newData1] = importfile12(filename);
str=vars{1};
eval(sprintf('in=newData1.%s;',str));

%%	Save to disk
in(:,2) = [];

[~, flname ~] = fileparts(filename);
flname = stripFileString(flname);
save(strcat(flname,'.raw.txt'),'-ascii','-double','-tabs','in');

%%	Clear variables
clearvars -except in;
