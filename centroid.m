function cntrd = centroid(indat,ndim)


%   centroid(indat,ndim). Find centroid of a vector or matrix of data.
%
%   Inputs:
%
%      - indat: input vector or matrix of data. 
%               By default, each column is treated as a separate vector.
%      - ndim:  OPTIONAL scalar double, to 'override',
%               if needed, the default behavior described above. 
%               ndim = 1 is the same as default behavior. 
%               ndim = 2 means each *row* is treated as a separate vector.
%
%   Outputs:
%
%      - cntrd: scalar or vector of centroid values, 
%               depending on number of 'vectors' in indat. 
%               If columns of indat are vectors, then cntrd 
%               is a row vector. If rows of indat are vectors, 
%               then cntrd is a column vector.
%
%   Other m-files required: None.
%   Sub-functions required: None.
%   MAT-files required: None.
%
%   See also: None.


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.0
%	Last Revised:	Mon Nov 10 21:28:33 2014
%
%	Changelog:
%
%		

%    License:       Please see license.txt in the same repository. 
%                   In short, this code uses the MIT license: 
%                   http://opensource.org/licenses/MIT

%%  Check arguments

if ~exist('ndim','var')
	ndim = 1;
elseif ndim > 2
	warning('row-column indentifier > 2. Using 2 instead.');
	ndim = 2;
elseif ndim < 1
	warning('row-column indentifier < 1. Using 1 instead.');
	ndim = 1;	
end

%%  Initialize

dimchoose = [2,1];

if ndim == 1
	cntrd = zeros(1,size(indat,dimchoose(ndim)));	%	if ndim = 1, choose number of cols
else
	cntrd = zeros(size(indat,dimchoose(ndim)),1);	%	if ndim = 2, choose number of rows
end

%%  Loop

for jj = 1: size(indat,dimchoose(ndim)) 	%	if ndim = 1, run for each col; if ndim = 2, run for each row
	
	ssnum = 0;
	for kk = 1: size(indat,ndim) 			%	if ndim = 1, run for elems of row; if ndim = 2, run for elems of col

		if ndim == 1
			ssnum = ssnum + kk*indat(kk,jj);
		else
			ssnum = ssnum + kk*indat(jj,kk);
		end
	end

	if ndim == 1
		cntrd(1,jj) = ssnum/sum(indat(:,jj)); 
	else
		cntrd(jj,1) = ssnum/sum(indat(jj,:));
	end
end