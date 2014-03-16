function get_AllRAW_fromExptData(ext)


	%%	Initialize

	if nargin > 1
		disp('Ignoring extra arguments');
	elseif nargin < 1
		ext = '*.sig';
	end

	%%	Get list of files

	files = dir(fullfile(ext));
	filename = {files(:).name}';

	clear files;

	szfile = size(filename);

	%%	Loop

	% parpool;

	parfor kk = 1: szfile(1)

		%%

		fprintf('%d\t',kk);
		if mod(kk,10) == 0
			fprintf('\n');
		end

		%%

		in = extractRaw(filename{kk,1});

	end

	%% Move files into folder

	movefile('*.raw.txt','../rawdata');





