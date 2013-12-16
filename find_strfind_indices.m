function idx = find_strfind_indices(refCellArray,testString)


%   find_strfing_indices. Find index numbers of string 
%						  matches found using strfind().
%	
%	idx = find_strfind_indices(refCellArray,testString)
%
%   Inputs:
%
%       refCellArray:	Cell array of strings, this is the
%						reference to be compared against.
%	
%		testString:		String to serve as value to be found.
%
%   Outputs:
%
%       idx:			Array of index values where matches occur.
%
%   Other m-files required:    None
%   Subfunctions required:     None
%   MAT-files required:        None
%    
%   See also: strfind


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.0
%	Last Revised:	16 December 2013
%
%	Changelog:
%


idx = strfind(refCellArray,testString);
idx = find(~cellfun(@isempty,idx));