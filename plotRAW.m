function plotRAW(ext)


%	plotRAW. Function to plot data from a set of raw data
%	         data files into separate figures and save to disk.
%
%	Inputs:
%
%			- ext: String, to identify data files in current 
%	               directory for analysis. eg.: '*.raw.txt'
%
%	Outputs:
%
%			- Figure files are saved to disk, and moved to 
%	          separate folder.
%
%	Other m-files required: stripFileString.m, prettyPlot.m.
%	Sub-functions required: None.
%	MAT-files required: None.
%
%	See also: prettyPlot.m.


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.0
%	Last Revised:	Wed Jan 29 11:36:11 2014
%
%	Changelog:
%
%		




%%

if nargin == 0
	ext = '*.raw.txt';
end

%%	Identify files to use

files = dir(fullfile(ext));
filename = {files(:).name}';
clear files;

szfile = size(filename);

%%	Loop

for i = 1: szfile(1)

	%%
	fprintf('%d\t',i);
	if mod(i,10) == 0
		fprintf('\n');
	end


	%%

	fdat = load(filename{i,1},'-ascii');

	[~, flname, ~] = fileparts(filename{i,1});

	flname = stripFileString(flname);

	%%	Plot

	figH = figure('Visible','off');

	plot(fdat(:,1)*10^6,fdat(:,2));
	title(sprintf('Signal %02d -- %02d',str2num(flname(end-5:end-2)),str2num(flname(end-1:end))));
	xlabel('Time (\mus)');
	ylabel('Amplitude');
	% xlim([0 1]);
	
	grid on;

	prettyPlot(figH);

	%%

	figtype = 'png';
	orient landscape;
	saveas(figH, strcat(flname,'.raw.',figtype));
	close(figH);

end

fprintf('\n');	%	to insert a newline.

movefile(strcat('*.',figtype),strcat('./raw',figtype));

clearvars

