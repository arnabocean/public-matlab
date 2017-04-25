function [coluniqs, numuniqs] = getUniqCellCols1(indat, colnums)


%   getUniqCellCols. Function to return list of unique elements from cell array of data, based on selected columns.
%
%   Inputs:
%
%           - indat:     Cell matrix. Input data, where each column denotes a 
%                        different variable. Data in different columns can be 
%                        either of double type or string type, but all data in
%                        *each* column must be of consistent type.
%                        Size: [n1, n2], where n1 is the number of rows of data
%                        and n2 is the number of variables (columns).
%    
%           - colnums:   Double column numbers.
%                        (These are the columns whose unique values will be found.)
%                        Size: [r1, 1] where r1 is of course < n2.
%        
%
%   Outputs:
%
%           - coluniqs:  Cell matrix. Each column corresponds to successive
%                        values in colnums. Rows in each column contain unique
%                        values of that column found in indat.
%    
%           - numuniqs:  Double row vector. Each value corresponds to number
%                        of unique values in each column of coluniqs.
%
%   Other m-files required: None.
%   Sub-functions required: None.
%   MAT-files required: None.
%
%   See also: None.


%    Author:            Arnab Gupta
%                       Virginia Tech Transportation Institute
%    Email:             agupta@vtti.vt.edu
%    Website:           http://www.vtti.vt.edu
%
%    Version:           2.1
%    Last Revised:      Mon Jan 26 2015
%
%    Changelog:
%       3 June 2014:    Major update to algorithm. Faster now.
%       Jan 26 2015:    Bugfix. Added if statement inside 'try' and added flagnumeric logic to handle non-numeric cell arrays handled fine (unintentionally) by cell2mat.
%        

%%

if ~exist('colnums','var')
    colnums = 1: size(indat,1);
end

%%

numuniqs = [];
coluniqs = {};

%%
for kk = 1: length(colnums)

    flagnumeric = 0;
    try
        tmp = unique(cell2mat(indat(:,colnums(kk))));
        if isnumeric(tmp)
            numuniqs(1,kk) = length(tmp);
            coluniqs(1:numuniqs(kk),kk) = num2cell(tmp);
        else
            flagnumeric = 1;
        end
    catch
        flagnumeric = 1;
    end

    if flagnumeric == 1
        tmp = unique(indat(:,colnums(kk)));
        numuniqs(1,kk) = length(tmp);
        coluniqs(1:numuniqs(kk),kk) = tmp;
    end

end

clearvars -except coluniqs numuniqs

