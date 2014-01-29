function plotRAWsets(nn,ext,mm)
	
	
%	Function to plot sets of raw data from a bunch of files. 
%	This helps to visualize the overall behavior of a number
%	of signal records. 
%	
%	Of course, the code can be easily modified to run with 
%	other data sets. This function is analogous to plotFFTsets.m
%	
%	The number of data records to be combined is given by nn,
%	and the starting point is optionally given by mm. When mm
%	is not specified, the starting point is the first data 
%	record.
%	
%	ext is the search criteria for finding data record files.
%	Thus if ext = '*.txt', the program looks for '*.txt' in the
%	current folder. This allows this program to be versatile
%	and handle any kind of data record.
%	
%	*****
%	The program, however, is written for raw data signals. 
%	Thus there is no provision for changing the title, xlabel,
%	ylabel, and xlim values. If this is used for other data 
%	records, please update plotting parameters as suitable
%	before plotting.
%	*****
%	
%	Inputs:
%	
%	Option 1: 	plotRAWsets
%				start index = 1; end index = 50 (default nn)
%	
%	Option 2: 	plotRAWsets(nn,ext)
%				start index = 1; end index = nn
%	
%	Option 3:	plotRAWsets(nn,ext,mm)
%				start index = mm; end index = mm + nn - 1
%				(i.e. the code still runs for nn files, but 
%				the starting point is shifted to mm)
%	
%	! Future work:
%	
%	Code currently performs Bessel filter operation before plotting.
%	I have to modify the code to make this optional.	
%	
%	Include option to parameterize xlabel, ylabel, xlim,
%	title values so that it is easier to run the same code with
%	other data records.
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
%	Last Revised:	Wed Jan 29 12:13:39 2014
%
%	Changelog:
%	

%%	Check input arguments

if nargin > 3
	error('Too many arguments.');
elseif nargin == 3
	startindex = mm;
	endindex = mm + nn - 1;
elseif nargin == 2
	startindex = 1;
	endindex = nn;
elseif nargin == 1
	startindex = 1;
	endindex = nn;
	ext = '*.raw.txt';
elseif nargin == 0
	ext = '*.raw.txt';
	nn = 50;
	startindex = 1;
	endindex = nn;		
end

if startindex > endindex
	error('Start index > end index!');
end

%% Identify files to be imported

files = dir(fullfile(ext));

%%	Loop through files identified

count = startindex;
for i = 1: min(nn,length(files))
	
	if count > length(files)
		count = length(files);
	end
    filename{i,1} = files(count,1).name;
	count = count + 1;
	
	if count > length(files)
		endindex = count - 1;
		break;
	end
end

clear files;

%%	Set up figure

figure1 = figure;	
axes1 = axes('Parent',figure1,'FontSize',14);
box(axes1,'on');
grid(axes1,'on');

xlabel('Time (\mu s)','FontSize',16);
ylabel('Amplitude (V)','FontSize',16);
titletext = sprintf('Raw Data Combined, files %d to %d',startindex,endindex);
title(titletext,'FontSize',18);

%%	Set up other plot parameters

globalymax = 0.1;
% xlim(axes1,[0 1e3]);
% ylim(axes1,[0 globalymax]);

hold on;

%%	Plot through data files!

for i = 1: length(filename)

    fprintf('%d\t',i);
	if mod(i,10) == 0
		fprintf('\n');
	end


	[pathstr flname flext] = fileparts(filename{i,1});


	in = importdata(filename{i,1});
	in(:,2) = getBessel(in(:,2));


	globalymax = max(globalymax,max(in(:,2)));
	% ylim(axes1,[0 globalymax]);
	hold on;
	
	plot(in(:,1)*10^6,in(:,2));

end

%%	Polish and save

prettyPlot(figure1);
outformat = '.png';

orient landscape

testexist = dir(strcat('RAWSet*',outformat));
flname = strcat('RAWSet',num2str(length(testexist)+1,'%02d'));

saveas(figure1, strcat(flname,outformat));

close(figure1);

clear in figure1 axes1 pathstr flname flext

clear filename i

	
