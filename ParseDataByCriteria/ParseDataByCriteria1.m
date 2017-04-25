
%	ParseDataByCriteria. Script to 'parse' a large data set based on given criteria and return sorted data.
%
%	Inputs:
%
%		The following variables must be present in the workspace:
%	
%		- DRData:  Cell matrix of data. Each column corresponds to
%				   a different 'parameter' or 'variable'. Number of 
%				   rows indicate number of data points. Data in 
%				   different columns can be of either double or 
%				   string data types, but all data in *each* column
%				   must be of consistent data type.
%	
%		- col_list: Double row vector of column numbers to parse by.
%
%	Outputs:
%
%		The following variables are created in the workspace:
%	
%		- Series of variables named DatSeq01, DatSeq02, and so on.
%	
%		Each 'sequential' variable denotes an 'order' of sorting.
%		For example, if colnames = {'col1';'col2';'col3'}, then 
%		DatSeq01 represents data sorted by col1 only.
%		DatSeq02 represents data sorted by col1 and col2.
%		DatSeq02 represents data sorted by col1, col2 and col3.
%	
%		Therefore, number of variable created equals the number of 
%		elements in colname.
%	
%	
%		*Note: This is a completely 'nondestructive' data analysis
%			   procedure, and every element of the original data
%			   is preserved in cells in the DatSeq variables, as 
%			   sub-matrix data. For every instance of "data where
%			   col1 = val1 and col2 = val2" there is a cell in the 
%			   corresponding DatSeq variable which *actually contains*
%			   the entire sub-data.
%
%	Other m-files required: singleColSubData.m, getUniqCellCols.m.
%	Sub-functions required: None.
%	MAT-files required: None.
%
%	See also: singleColSubData.m, getUniqCellCols.m.


%	Author:			Arnab Gupta
%					Virginia Tech Transportation Institute
%	Email:			agupta@vtti.vt.edu
%	Website:		http://www.vtti.vt.edu
%
%	Version:		1.0
%	Last Revised:	4 June 2014
%
%	Changelog:
%
%		4 June 2014: Added documentation.

%%

[valuelist, numuniqs] = getUniqCellCols1(DRData, col_list);

%%	Initialize loop variables

seqnum = 1;			%	Which 'column-level' is being handled right now?
seqloopcount = 1;	%	How many times must the major sub-script be run?

%%	Master while loop; runs once for each specified column being analyzed by

while seqnum <= length(col_list)
	
	%% Modify seqloopcount. How many times to run script to get sub-data?
	if seqnum == 1
		seqloopcount = 1;
	else
		optionslength = length(find(~cellfun(@isempty,valuelist(:,seqnum-1))));
		seqloopcount = seqloopcount*optionslength;
		clear optionslength
	end
	
	%% What are the answer options for this particular column?
	
	colvalues = valuelist(1:numuniqs(seqnum),seqnum);
        
	%%	Loop for running sub-script that creates each sub-data-cell
    for k = 1: seqloopcount
		
        %%	Identify subset of all data that is pertinent for this run
        if seqnum == 1
			allData = DRData;
		else
			
			tmpstr = sprintf('tmpLen = size(DatSeq%02d,1);',seqnum-1);
			eval(tmpstr); clear tmpstr;
			
			if k > tmpLen		%	for the case where a previous loop contained no data for an index, but a following loop wants to access that index.
				allData = [];
			else
				tmpstr = sprintf('allData = DatSeq%02d{k,1};',seqnum-1);
				eval(tmpstr); clear tmpstr;
			end
        end
				
        if isempty(allData)		%	If a previous loop found no data, then no need to continue current loop
            continue;
        end
        
        %%	Identify column number corresponding to present column being analyzed
		thisCol = col_list(seqnum);
        for p = 1: seqnum - 1
			if col_list(p) < col_list(seqnum)
				thisCol = thisCol - 1;	%	modify thisCol based on whether previous loops already used a lower column number as a criterion. In that case, the column number will be reduced on each successive run.
			end
        end
        clear p;
        
        %%	Run script to find relevant sub-data for this loop. Save to a master cell.

		thisDat = singleColSubData(allData,colvalues,thisCol);

		tmpstr = sprintf('DatSeq%02d((k-1)*length(colvalues)+1:k*length(colvalues),1) = thisDat;',seqnum);
		eval(tmpstr);
		clear tmpstr;
		
		%%	Fill out column answer options for each run.
		
		for p = 1: seqnum
			
			if p == seqnum
				tmpstr = sprintf('DatSeq%02d((k-1)*length(colvalues)+1:k*length(colvalues),p+1) = colvalues;',seqnum);
				eval(tmpstr);
				clear tmpstr;
				
			else
				tmpdiv = 1;
				for r = p+2: seqnum
					tmpdiv = tmpdiv * length(find(~cellfun(@isempty,valuelist(:,p))));
				end
				
				tmpstr = sprintf('DatSeq%02d((k-1)*length(colvalues)+1:k*length(colvalues),p+1) = DatSeq%02d(k,p+1);',seqnum,seqnum-1);
				eval(tmpstr);
				clear tmpstr;
			end
        end
        clear p
					
    end
    
    %%	Loop Update!
	seqnum = seqnum + 1;
end

%%	Clean up output variables

for k = 1: length(col_list)
	tmpstr = sprintf('DatSeq%02d=DatSeq%02d(~cellfun(@isempty,DatSeq%02d(:,1)),:);',k,k,k);
	eval(tmpstr);
end


%%	Clear variables
clear thisCol thisDat tmpdiv tmpstr
clear allData k p r seqnum seqloopcount tmpLen

%%	Clear More Variables

clear colvalues valuelist numuniqs

