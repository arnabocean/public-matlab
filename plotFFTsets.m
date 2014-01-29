function plotFFTsets(nn,ext,mm)
	
	
%	Function to plot fft data from a bunch of files. This 
%	helps to visualize the overall behavior of a number of
%	signal records. 
%	
%	Of course, the code can be easily modified to run with 
%	other data sets.
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
%	The program, however, is written for FFT signals. 
%	Thus there is no provision for changing the title, xlabel,
%	ylabel, and xlim values. If this is used for other data 
%	records, please update plotting parameters as suitable
%	before plotting.
%	*****
%	
%	Inputs:
%	
%	Option 1: 	plotFFTsets
%				start index = 1; end index = 50 (default nn)
%	
%	Option 2: 	plotFFTsets(nn,ext)
%				start index = 1; end index = nn
%	
%	Option 3:	plotFFTsets(nn,ext,mm)
%				start index = mm; end index = mm + nn - 1
%				(i.e. the code still runs for nn files, but 
%				the starting point is shifted to mm)
%	
%	! Future work:
%		Include option to parameterize xlabel, ylabel, xlim,
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
%	Last Revised:	Fri Jan 17 18:13:35 2014
%
%	Changelog:
%	
%		Parameterized output file format (set to .png now)

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
	ext = '*.fft.txt';
elseif nargin == 0
	ext = '*.fft.txt';
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

xlabel('Frequency (kHz)','FontSize',16);
ylabel('Amplitude (V)','FontSize',16);
titletext = sprintf('FFT sets, files %d to %d, for %s',startindex,endindex,ext);
title(titletext,'FontSize',18);

%%	Set up other plot parameters

globalymax = 0.1;
xlim(axes1,[0 1e3]);
ylim(axes1,[0 globalymax]);

hold on;

%%	Plot through data files!

for i = 1: length(filename)

    fprintf('%d\t',i);
	if mod(i,10) == 0
		fprintf('\n');
	end


	in = importdata(filename{i,1});

	[pathstr flname flext] = fileparts(filename{i,1});

	% xlim(axes1,[0 1000000]);
	% ylim(axes1,[0 max(0.5,max(in(:,2)))]);

	globalymax = max(globalymax,max(in(:,2)));
	ylim(axes1,[0 globalymax]);
	hold on;
	
	% if max(in(:,2)) <= 0.5
	% if mod((i+1)/2-1,24) >= 4 && mod((i+1)/2-1,24) < 8
		plot(in(:,1)/1000,in(:,2));
	% end

end

%%	Polish and save

prettyPlot(figure1);
outformat = '.png';

orient landscape

testexist = dir(strcat('FFTSet*',outformat));
flname = strcat('FFTSet',num2str(length(testexist)+1,'%02d'));

saveas(figure1, strcat(flname,outformat));
% saveas(figure1, strcat(flname,'.fig'));

close(figure1);

clear in figure1 axes1 pathstr flname flext


% movefile('*.pdf','./fftpdf');
% movefile('*.fig','./fftfig');

clear filename i

	
