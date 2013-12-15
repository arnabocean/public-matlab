function flstr = stripFileString(filestr)

%	function flstr = stripFileString(filestr)
% 
% 	Function to strip out any series of extensions appended 
%	to the end of a fileID.
%
%	For example, if the input is "fileID.raw.bsl.fft.png" 
%	then the output will be "fileID".
%
%	Input:
%   	    filestr: string to be processed.
%	Output:
%   	    flstr: processed string, with extensions removed.
%	
%   License:        Please see license.txt in the same repository. 
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
%	Last Revised:	30 June 2013
%
%	Changelog:
%
%		



count = 1;
while (count == 1)
    [~, flstr, ~] = fileparts(filestr);
    
    if strcmp(flstr,filestr)
        count = 0;
    else
        filestr = flstr;
    end
end
