function plotRAW(ext, figtype, mvtargetdir)

%	plotRAW. Function to plot data from a set of raw data
%	         files into separate figures and save to disk.
%
%	Inputs:
%			All input arguments are optional, and can be either omitted or an empty variable.
%			- ext: String, to identify data files in current 
%	               directory for analysis. eg.: '*.raw.txt' (default)
%   		- figtype: file format to save figure, example 'png' (default) or 'pdf'
%   		- mvtargetdir: (optional) folder to move all files to. If specified,
%                          folder is created in the parent directory of current folder.
%
%	Outputs:
%
%			- Figure files are saved to disk, and optionally moved to 
%	          separate folder.
%
%	Other m-files required: AG_setPaper, prettyPlot.m.
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
%	Last Revised:	27 March 2016
%
%	Changelog:
%
%		


%%

if ~exist('ext','var') || isempty(ext)
	ext = '*.raw.txt';
end

if ~exist('figtype','var') || isempty(figtype)
	figtype = 'png';
end

%%

files = dir(fullfile(ext));
filename = {files(:).name}';
clear files;

%%

parfor jj = 1: size(filename,1)

	%%
	fdat = load(filename{jj,1},'-ascii');
	[~,flname,~] = fileparts(filename{jj,1});

	%%

	fH = figure('Visible','Off');

	plot(fdat(:,1)*1E6, fdat(:,2));
	xlabel('Time (\mus)');
	ylabel('Amplitude (V)');

	title('Time vs. Amplitude');
	grid on;

	prettyPlot(fH);

	%%

	% figtype = 'png';
	AG_setPaper;
	orient landscape;
	print('-r150',strcat(flname,'.',figtype),'-dpng');

	%%
	close(fH);
end

%%

if exist('mvtargetdir','var') && ~isempty(mvtargetdir)
	movefile(strcat('*.',figtype), strcat('../',mvtargetdir));
end

