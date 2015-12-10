function dblMat = convertCellToDouble(cellMat)


%   converCellToDouble. Convert a cell matrix (with not all numeric elements) to a numeric matrix
%
%   Inputs:
%
%      - cellMat: Input cell matrix consisting primarily of numeric elements.
%
%   Outputs:
%
%      - dblMat: Output cell matrix consisting entirely of numeric elements. Cells corresponding to non-numeric elements in cellMat are represented by NaN values.
%
%   Other m-files required: None.
%   Sub-functions required: None.
%   MAT-files required: None.
%
%   See also: None.


%   Author:         Arnab Gupta
%                   Ph.D. Candidate, Virginia Tech.
%                   Blacksburg, VA.
%   Website:        http://arnabocean.com
%   Repository:     http://bitbucket.org/arnabocean
%   Email:          arnab@arnabocean.com
%
%   Version:        1.0
%   Last Revised:   Mon Nov 30 2015
%
%   Changelog:
%
%      




dblMat = NaN(size(cellMat));

for jj = 1: size(cellMat,2)

	idx = cellfun(@isnumeric,cellMat(:,jj));
	idx = find(idx==1);

	if isempty(idx)
		warning(sprintf('Column %d has no numeric elements.',jj));
		continue;
	end

	try
		dblMat(idx,jj) = cell2mat(cellMat(idx,jj));
	catch
		warning(sprintf('Error converting column %d.',jj));
	end
end
