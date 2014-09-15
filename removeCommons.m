function filename = removeCommons(ext1,ext2,userootname)

%	removeCommons. Function to compare two lists of filenames from disk
%	                  and return a list of filenames NOT common to both of them.
%
%	Inputs:
%
%	        - ext1: String to be used to get directory listing of source files 
%	                from disk. Eg. '*.mat'.
%	        - ext2: String to be used to get directory listing of test files 
%	                from disk. Eg. '*.png'.
%	        - userootname: Either 0 (false) or 1 (true). Default value is 0. 
%	                If userootname = 1, the function uses the root name of each
%	                file for comparison. 
%	                If userootname = 0, the function only removes the file 
%	                extension from each file before comparing.
%	                Eg., if a filename is 'testfile.v1.mod.txt.md', 
%	                userootname = 0 uses 'testfile.v1.mod.txt' for comparison.
%	                userootname = 1 uses 'testfile' for comparison.
%	
%	        * The function can be run with NO ARGUMENTS, in which case the defaults are:
%	                ext1 = '*.mat'; ext2 = '*.png'; userootname = 0;
%                  
%
%	Outputs:
%
%			- filename: Cell array of filenames. This is a subset of the file list 
%	                obtained by searching current directory with ext1.
%
%	Other m-files required: stripFileString.m.
%	Sub-functions required: None.
%	MAT-files required: None.
%
%	See also: None.


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		2.0
%	Last Revised:	Mon Sep 15 04:59:13 2014
%
%	Changelog:
%
%		Mon Sep 15 04:59:18 2014: Major update to algorithm, using logical indexing and builtin functions, so that code now runs about 3 time faster.




%%	Argument check
if nargin == 1
	disp(sprintf('Warning: Insufficient arguments. Empty variable is output.\n\nUse help removeCommons for information.'));
	filename = {};
	return;
elseif nargin == 0
	ext1 = '*.mat';
	ext2 = '*.png';
	userootname = 0;
elseif nargin == 2
	userootname = 0;
end

%%	Initialize

filename = {};

%%	Get lists of filenames to compare

%	Gather list of source files. Result: srcfiles

files = dir(fullfile(ext1));
srcfiles = sort({files.name})';

clear files

%	Gather list of test files. Result: tstfiles

files = dir(fullfile(ext2));
tstfiles = sort({files.name})';

clear files

%%	Consider trivial case of NO common files, i.e. empty tstfiles

if isempty(tstfiles)
	filename = srcfiles;
	clearvars srcfiles tstfiles
	return
end

%%	Compare

if userootname == 0
	[~, modsrcflname, ~] = cellfun(@fileparts,srcfiles,'UniformOutput',0);
	[~, modtstflname, ~] = cellfun(@fileparts,tstfiles,'UniformOutput',0);
else
	modsrcflname = cellfun(@stripFileString,srcfiles,'UniformOutput',0);
	modtstflname = cellfun(@stripFileString,tstfiles,'UniformOutput',0);
end


filename = srcfiles(~ismember(modsrcflname,modtstflname));

clear modtstflname modsrcflname srcfiles tstfiles




