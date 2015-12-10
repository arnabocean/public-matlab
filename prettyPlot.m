function prettyPlot(figH, TeXTrue, fontNameList, fontSizeList)

%   prettyPlot. Function to make a Matlab figure look pretty.
%
%   Inputs:
%
%      - figH: Figure Handle (optional; defaults to gcf).
%      - TeXTrue: Set title interpreter as LaTeX? Options: 0 (no), 1 (yes). (Optional; defaults to 0). Note that this only affect the font choice. The title automatically detects LaTeX syntax.
%      - fontNameList: Cell array of font names to use for Title, Labels and all other text. size(fontNameList) = (1,3). (Optional, default values are within program).
%      - fontSizeList: Double array of font sizes to use for Title, Labels and all other text. size(fontSizeList) = (3,1). (Optional, default values are within program).
%
%   Outputs:
%
%      - None.
%
%   Other m-files required: None.
%   Sub-functions required: None.
%   MAT-files required: None.
%
%   See also: None.
%
%   License:       Please see license.txt in the same repository. 
%                  In short, this code uses the MIT license: 
%                  http://opensource.org/licenses/MIT


%   Author:         Arnab Gupta
%                   Ph.D. Candidate, Virginia Tech.
%                   Blacksburg, VA.
%   Website:        http://arnabocean.com
%   Repository:     http://bitbucket.org/arnabocean
%   Email:          arnab@arnabocean.com
%
%   Version:        2.1
%   Last Revised:   Thu Dec 10 2015
%
%   Changelog:
%
%      


%%	Initialize

if nargin == 0
	figH = gcf;
end

if ~exist('fontNameList','var')

	if ismac
		% fontNameList = {'Book Antiqua','Book Antiqua','Book Antiqua'};
		fontNameList = {'Century Schoolbook','Century Schoolbook','Century Schoolbook'};
% 		fontNameList = {'Avenir','Avenir','Avenir'};
	elseif ispc
		% fontNameList = {'Book Antiqua','Book Antiqua','Book Antiqua'};
		fontNameList = {'Century Schoolbook','Century Schoolbook','Century Schoolbook'};
		% fontNameList = {'Arial','Arial','Arial'};
	else
		fontNameList = {'Century Schoolbook','Century Schoolbook','Century Schoolbook'};
	end
end

if ~exist('fontSizeList','var')
	fontSizeList = [16; 14; 12];	%	Title; Fig Texts (x- and y- labels); Axes Texts (ticks, legends)
end

if ~exist('TeXTrue','var')
	TeXTrue = 0;
end

%%

set(findall(figH,'type','text'),'FontSize',fontSizeList(2),'FontName',fontNameList{2});

chlds = get(figH,'Children');

for kk = 1: length(chlds)
	set(chlds(kk),'FontSize',fontSizeList(3),'FontName',fontNameList{3});

	try
		if TeXTrue == 0
			set(get(chlds(kk),'Title'),'FontSize',fontSizeList(1),'FontName',fontNameList{1},'FontWeight','bold');
		else
			set(get(chlds(kk),'Title'),'FontSize',fontSizeList(1),'FontName',fontNameList{1},'FontWeight','bold','Interpreter','Latex');
		end
	catch
		continue;
	end
end
