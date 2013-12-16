function teststr = splitstring(teststr,maxlen)
	
%   splitstring. Split a longer string into new string that 
%				 flows to multiple lines.
%	
%	MODIFIEDSTR = splitstring(INPUTSTR,MAXLEN)
%
%   Inputs:
%
%       INPUTSTR: 	char array, this is the input string to be split.
%		MAXLEN:	  	double, this is the max length of each string section
%
%   Outputs:
%
%       MODIFIEDSTR:	char array, this is the output string.
%
%   Other m-files required:    None
%   Subfunctions required:     None
%   MAT-files required:        None
%    

%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		2.0
%	Last Revised:	01 Dec 2013
%
%	Changelog:
%
%		Major update to algorithm. Now the output is a string with newline
%		character embedded, instead of a cell of strings.


%%	Error checking

if nargin > 2
	disp(['Too many arguments in call to splitstring.' char(10) 'Ignoring extra arguments.']);
elseif nargin == 2
	if ~isnumeric(maxlen) || max(size(maxlen,1),size(maxlen,2)) > 1 || maxlen < 0
		error('Argument maxlen must be a positive scalar numeric.');
	end
elseif nargin == 1
	maxlen = 60;	%	Random default value. :P
elseif nargin < 1
	error('Too few arguments.');
end

%%	Exit if no changes are required

if maxlen == 0 || length(teststr) <= maxlen
	return;
end

%% Algorithm

idx = 1;	%	starting index
while idx <= length(teststr)

	k = idx + maxlen - 1;	%	consider string fragment of length maxlen
	if k >= length(teststr)	%	if you overshoot the string, no need to run any more.
		idx = k + 1;		%	Update idx, and this automatically makes the while criterion false on next iteration.
		continue;
	end

	flag = 1;				
	while flag == 1 				%	find word-end near max fragment length (we don't want to break the string mid-word)
		
		if k == 0
			error('Argument maxlen is too low. Use a higher value for maxlen.');
		end

		if teststr(k) == char(32)	%	ASCII 32 == space
			teststr(k) = char(10);	%	char(10) is the newline character, '\n'
			flag = 0;				%	found word-end; no need to run again.
		else
			k = k - 1;				%	not a word-end. move backwards until we reach end of previous word.
		end
	end

	idx = k + 1;					%	Update index to consider next string fragment during next iteration
end

return;
