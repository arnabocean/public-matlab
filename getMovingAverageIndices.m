function outData = getMovingAverageIndices(timelist,winsize)


%   getMovingAverageIndices. Identify vector indices to calculate moving averages based on a fixed window size.
%
%   Inputs:
%
%      - timelist: Vector of time values
%      - winsize:  Fixed window size to be used
%
%   Outputs:
%
%      - outData: Two column vector denoting start and end points for each window.
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
%   Last Revised:   Thu Oct 27 12:01:27 2016
%
%   Changelog:
%
%      


%%	Test input data
if isempty(winsize)
	winsize = 1;
end

if length(winsize) > 1
	winsize = winsize(1,1);
end

%%	Initialize

outData = zeros(length(timelist),3);

flag = 1;
jj = 1;

%%
while flag == 1		%	Control outer loop with a flag

	%%
	kk = jj;		%	For each window, set end point = start point to begin
	flag1 = 1;		%	Inner while loop control

	outData(jj,1) = jj;		%	Save start point...
	%%	...and now to find end point
	while flag1 == 1

		if timelist(kk) - timelist(jj) >= winsize || abs(kk-length(timelist))<=eps
			flag1 = 0;		%	Stop loop if either: (a) window size is exceeded, or (b) index reaches end of data vector
		elseif timelist(kk) - timelist(jj) < winsize
			kk = kk + 1;	%	If loop is not stopped, keep going to the next index!	
		end
	end
	outData(jj,2) = kk;		%	Wherever loop is stopped marks the end point of the window
	outData(jj,3) = timelist(kk) - timelist(jj);	%	Calculate window width
	%%

	if kk == length(timelist)	%	if window end point has reached end of data vector, time to stop outer loop
		flag = 0;
	else 						%	...otherwise, start next window with the next index.
		jj = jj + 1;
	end
end

%%

outData(jj+1:end,:) = [];		%	Delete any extra cells that were created




