function get_AllCWT_2017(ext,tstExt,wvlt,scales)

%%

if ~exist('ext','var')	%	Files list not provided; use default search string
	ext = '*.raw.txt';	
elseif iscell(ext)		%	List of files already provided
	disp('Processing provided files only.');
	filename = ext;
	clear ext
end

if exist('ext','var') && exist('tstExt','var')	%	If both exist, find the subset of files not processed yet.
	filename = removeCommons(ext,tstExt,1);
elseif exist('ext','var')						%	If only ext exists, search dir for list of files
	files = dir(fullfile(ext));
	filename = {files(:).name}';

	clear files;	
end

%%

if ~exist('wvlt','var')
	wvlt = 'morl';
end

if ~exist('scales','var')
	% fflist = 60000:40000:500000;
	% fflist = 1000*[60,100,160,220,260,300,360,400,430,460];;
	fflist = 1000*[60,100,160,220,260,300,360,430,480,530];
	scales = 5/(2*pi)*25E6./fflist;
end

disp(size(filename));
%%

for kk = 1: size(filename,1)

	%%

	[~, flname, ~] = fileparts(filename{kk,1});
	in = load(filename{kk,1});
	cw1 = getCWT(in(:,2),scales,wvlt,flname);

end

%%

movefile('*.mat','../RAWCWTMAT');

clearvars



