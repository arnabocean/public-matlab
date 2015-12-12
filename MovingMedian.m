function mvMed = MovingMedian(datVect,mlen)


%   MovingMedian. Find moving Median of an input data vector.
%
%   Inputs:
%
%      - datVect: input data vector, either as row or column vector.
%      - mlen: OPTIONAL number of data points used for computing 
%              the moving Median. Default value: 1/10 of vector length.
%              * NOTE: If mlen is input as an even number, 
%                      mlen is increased to mlen+1, an odd 
%                      number, for convenience of computations.	
%
%   Outputs:
%
%      - mvMed: Moving Median vector, of same size() as datVect. 
%               Note that first few and last few values of mvMed 
%               will be zero.
%
%   Other m-files required: None.
%   Sub-functions required: None.
%   MAT-files required: None.
%
%   See also: MovingAverage.m.


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.1
%	Last Revised:	Fri Jan  9 20:59:45 2015
%
%	Changelog:
%		
%   	Sat Dec 12 2015: Changed line mvAvg = zeros(size(datVect)); to mvAvg = NaN(size(datVect)); so that buffer elements can be clearly identified.




%%	Initialize and Check

if ~exist('mlen','var')
	mlen = ceil(length(datVect)/10);
end

%%	If mlen is even, make it odd

if mod(mlen,2) == 0
	mlen = mlen + 1;
end

%%	Loop! 
mvMed = NaN(size(datVect));

for kk = ceil(mlen/2): length(datVect)-floor(mlen/2)

	mvMed(kk)=median(datVect(kk-floor(mlen/2):kk+floor(mlen/2)));
end



