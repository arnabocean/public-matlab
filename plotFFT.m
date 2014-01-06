function plotFFT(ext)


%%

if nargin == 0
	ext = '*.fft.txt';
end

%%	Identify files to use

files = dir(fullfile(ext));

for i = 1: length(files)

    filename{i,1} = files(i,1).name;
end

clear files;

szfile = size(filename);

%%	Loop

for i = 1: szfile(1)

	%%
	if mod(i,10) == 1
		fprintf('%d\t',i);
	end

	%%

	fdat = load(filename{i,1},'-ascii');

	[~, flname, ~] = fileparts(filename{i,1});

	flname = stripFileString(flname);

	%%	Plot

	figH = figure('Visible','off');

	plot(fdat(:,1)*10^-6,fdat(:,2));
	title(sprintf('Signal %02d -- %02d',str2num(flname(end-5:end-2)),str2num(flname(end-1:end))));
	xlabel('Frequency (MHz)');
	ylabel('Amplitude');
	xlim([0 1]);

	prettyPlot(figH);

	%%

	figtype = 'png';
	orient landscape;
	saveas(figH, strcat(flname,'.fft.',figtype));
	close(figH);

end

fprintf('\n');	%	to insert a newline.

movefile(strcat('*.',figtype),strcat('./fft',figtype));

clearvars

