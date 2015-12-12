function mvAvg = MovingAverage(datVect,mlen)


%   MovingAverage. Find moving average of an input data vector.
%
%   Inputs:
%
%      - datVect: input data vector, either as row or column vector.
%      - mlen: OPTIONAL number of data points used for computing 
%              the moving average. Default value: 1/10 of vector length.
%              * NOTE: If mlen is input as an even number, 
%                      mlen is increased to mlen+1, an odd 
%                      number, for convenience of computations.	
%
%   Outputs:
%
%      - mvAvg: Moving average vector, of same size() as datVect. 
%               Note that first few and last few values of mvAvg 
%               will be zero, as per usual moving average computations.
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
%	Version:		1.4
%	Last Revised:	Sat Dec 12 18:16:17 2015
%
%	Changelog:
%		
%   	Tue Dec 23 2014: Bugfixes to deal with default value of mlen. Updated documentation. 
%		Fri Jan  9 2015: Bugfix to make mvAvg same length as datVect. Added line: mvAvg = zeros(size(datVect));
%   	Sun May  3 2015: Added option to override function execution, which returns the unmodified input vector. Added lines in the Initialization section.
%   	Sat Dec 12 2015: Changed line mvAvg = zeros(size(datVect)); to mvAvg = NaN(size(datVect)); so that buffer elements can be clearly identified.




%%	Initialize and Check

if mlen == -1 		%	Provide option to override function execution and return unmodified input vector.
	mvAvg = datVect;
	return
end

if ~exist('mlen','var')
	mlen = ceil(length(datVect)/10);
end

%%	If mlen is even, make it odd

if mod(mlen,2) == 0
	mlen = mlen + 1;
end

%%	Loop! 
mvAvg = NaN(size(datVect));

for kk = ceil(mlen/2): length(datVect)-floor(mlen/2)

	mvAvg(kk)=sum(datVect(kk-floor(mlen/2):kk+floor(mlen/2)))/mlen;
end



