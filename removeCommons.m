function filename = removeCommons(ext1,ext2)

%	removeCommons. Function to compare two sets of files and
%				   create a list of files present in first set
%				   but not second.
%	
%	Function to compare lists of files in a folder and create
%	a new file list of unique files. In particular, the program
%	compares the result of a directory search of 'ext1' with a 
%	directory search of 'ext2', and creates the list of files in
%	the first search that are NOT PRESENT in the second search.
%	
%	This function was created for the particular use case where 
%	an input file is processed and an output file is created, and
%	the output file varies only in the file extension. In this
%	situation the same process can be continued by comparing the 
%	list of input and output files in the directory and only 
%	processing files for which the corresponding output file
%	doesn't exist.
%	
%	Input:
%	
%		-	No arguments. The defaults are: 'ext1' = '*.mat' and 
%			'ext2' = '*.png'.
%		-	Master and test extensions. 'Ext1' is the master list
%			of files to be searched. 'Ext2' is the test list to be
%			compared against.
%		*	Note that the string comparison appends the file 
%			extension of the test string to the file names of the 
%			master list when comparing.
%	
%	Output:
%		-	filename is a cell array of filenames. Each filename can
%			be accessed using filename{i,1}.
%	
%    License:       Please see license.txt in the same repository. 
%                   In short, this code uses the MIT license: 
%                   http://opensource.org/licenses/MIT

%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.0
%	Last Revised:	5 December 2012
%
%	Changelog:
%
%		



if nargin == 1
	disp(sprintf('Warning: Insufficient arguments. Empty variable is output.\n\nUse help removeCommons for information.'));
	filename = {};
	return;
elseif nargin == 0
	ext1 = '*.mat';
	ext2 = '*.png';
end

filename = {};

%	Gather list of .mat files. Result: matfilename
matfiles = dir(fullfile(ext1));

for i = 1: length(matfiles)

	matfilename{i,1} = matfiles(i,1).name;
end
clear matfiles
if ~exist('matfilename')
	matfilename = {};
end

%	Gather list of .png files. Result: pngfilename
pngfiles = dir(fullfile(ext2));
for i = 1: length(pngfiles)

	pngfilename{i,1} = pngfiles(i,1).name;
end
clear pngfiles
if ~exist('pngfilename')
	pngfilename = {};
end

if isempty(pngfilename)
	filename = matfilename;
	clearvars -except filename;
	return
end

%	Compare the two lists and eliminate commons.
j = 1;
for i = 1: length(matfilename)
	matstr = matfilename{i,1};

	[pathstr flname flext] = fileparts(matstr);
	[pathstr1 flname1 flext1] = fileparts(ext2);

	pngstr = strcat(flname,flext1);
	
	tmp = strfind(pngfilename,pngstr);
	
	if min(cellfun(@isempty,tmp)) == 1 % i.e. if all cells are empty
		filename{j,1} = matstr;
		j = j + 1;
	end
end

clearvars -except filename

