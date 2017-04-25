function allOutData = singleColSubData(allData,colValues,whichCol)

%   singleColSubData. Function to execute ONE ITERATION of 
%   a looped data analysis procedure for ParseDataByCriteria.m.
%   
%   This script considers a dataset set and a particular column
%   of data within that data set. Then it creates "sub-data"
%   matrices corresponding to each value of the column selected.
%   This is essentially a "sorting" procedure. These sub-data
%   matrices are saved as cells in a single variable.
%   
%   For example, if we are considering a "Weather" column in a 
%   larger data set, and 'Clear', 'Cloudy', 'Rainy', 'Fog' are 
%   data options in Weather, then sub-data matrices would be 
%   created for *all other columns* corresponding to cases where
%   Weather = 'Clear', 'Cloudy', and so on.
%   
%   Inputs:
%
%       - allData:    cell matrix containing all data being 
%                     considered.
%       - colValues:  Cell string array. Answer options for 
%                     particular column of focus. (This 
%                     determines how many times the master 'for' 
%                     loop must be iterated.)
%       - whichCol:   column number of allData that corresponds 
%                     to current column being considered.
%                     Essentially, elements in column number
%                     whichCol of allData are matched against
%                     each value in colValues.
%
%   Outputs:
%
%       - allOutData: cell matrix (as a column vector of cells) 
%                     containing sub-data-matrices of allData. 
%                     Each such matrix contains values corresponding 
%                     to each colValues string.
%
%    Other m-files required: None
%    Subfunctions required: None
%    MAT-files required: None
%    
%    See also:  ParseDataByCriteria.m, getUniqCellCols.m.


%   Author:         Arnab Gupta
%                   Virginia Tech Transportation Institute
%   Email:          agupta@vtti.vt.edu
%   Website:        http://www.vtti.vt.edu
%
%   Version:        2.0
%   Last Revised:   3 June 2014
%
%   Changelog:
%
%       3 June 2014: Major update to code. Much Faster now.
%       4 June 2014: Updated documentation.


%%
allOutData = cell(length(colValues),1);

if isempty(allData)
    return
end

remaincols = 1:size(allData,2); 
remaincols(whichCol) = [];      %   sub-data comprises all columns EXCEPT one we're parsing by.

%%
for kk = 1: length(colValues)

    %%  Find values corresponding to kk-th option
    flagrow = 0;    %   Used to "gather" all situations that require running one particular command, instead of repeating the same command multiple times.
    try
        idxAllvalues = find(cell2mat(allData(:,whichCol)) == colValues{kk,1});  %   if data is of type double       
        
        if size(allData,1) == 1 && max(idxAllvalues) > 1    %   This occurs in a special case where size(allData) = [1, n] where cell2mat works even when the argument is a string, and returns a row vector in case of a match. This is erroneous, and should actually be handled by the string version of find().
            flagrow = 1;
        end
    catch
        flagrow = 1;    %   If data type is of type string. Actual command is outside of "catch" to also capture the "special case" within the try segment above.
    end

    if flagrow == 1
        idxAllvalues = find(strcmp(allData(:,whichCol),colValues{kk,1}));       %   if data is of type string
    end

    %%  if idxAllvalues is empty

    if isempty(idxAllvalues)
         continue;
    end

    %%  Store data for i-th option in separate variable
    eachOutData = allData(idxAllvalues,remaincols);
    allOutData{kk,1} = eachOutData;

end

