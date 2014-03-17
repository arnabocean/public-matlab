function filename = removeCommons_BaseFilename(refExt,tstExt)

%	filename = removeCommons_BaseFilename(refExt,tstExt)
%	
%	Function to compare the base file names of two sets of files,
%	and return a list of files NOT COMMON between the two lists.
%	
%	Input:
%			refExt:		This is used to find the reference list.
%						Default value: '*.mat'
%	
%			tstExt:		This is used to find the test list.
%						Default value: '*.png'
%	
%	Output:
%			filename:	List of filenames ('.mat' in default case)
%						not present in test list ('*.png').
%	
%	Other m-files required:		stripFileString.m
%	Other MAT-files required:	None.


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.0
%	Last Revised:	Mon Mar 17 15:49:26 2014
%
%	Changelog:
%
%		

%%	Initialize and test

if nargin > 2
	disp('Ignoring extra arguments.');
elseif nargin == 1
	error('Insufficient arguments.');
elseif nargin == 0
	refExt = '*.mat';
	tstExt = '*.png';
end

if ~ischar(refExt) || ~ischar(tstExt)
	error('Argument type mismatch.');
end

%%	Get list of files

refFiles = dir(fullfile(refExt));
refList = {refFiles(:).name}';
clear refFiles;

tstFiles = dir(fullfile(tstExt));
tstList = {tstFiles(:).name}';
clear tstFiles;

%%	If any of the lists is empty, return appropriately

if max(size(refList)) == 0
	filename = {};
	return;
elseif max(size(tstList)) == 0
	filename = refList;
	return;
end

%% Process!

refListBasename = cellfun(@stripFileString,refList,'UniformOutput',0);
tstListBasename = cellfun(@stripFileString,tstList,'UniformOutput',0);

[diffList, idxList] = setdiff(refListBasename,tstListBasename);

filename = refList(idxList);
clearvars -except filename
return

