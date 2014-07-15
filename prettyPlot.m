function prettyPlot(figH, TeXTrue, fontNameList, fontSizeList)

%%	Initialize

if nargin == 0
	figH = gcf;
end

if ~exist('fontNameList','var')

	if ismac
		% fontNameList = {'Foglihten','Consolas','Consolas'};
		fontNameList = {'Avenir','Avenir','Avenir'};
	elseif ispc
		fontNameList = {'Palatino','Candara','Constantia'};
		fontNameList = {'Arial','Arial','Arial'};
	end
end

if ~exist('fontSizeList','var')
	fontSizeList = [18; 14; 14];	%	Title; Fig Texts (x- and y- labels); Axes Texts (ticks, legends)
end

if ~exist('TeXTrue','var')
	TeXTrue = 0;
end

%%

set(findall(gcf,'type','text'),'FontSize',fontSizeList(2),'FontName',fontNameList{2});

chlds = get(gcf,'Children');

for kk = 1: length(chlds)
	set(chlds(kk),'FontSize',fontSizeList(3),'FontName',fontNameList{3});

	
	if TeXTrue == 0
		set(get(chlds(kk),'Title'),'FontSize',fontSizeList(1),'FontName',fontNameList{1},'FontWeight','bold');
	else
		set(get(chlds(kk),'Title'),'FontSize',fontSizeList(1),'FontName',fontNameList{1},'FontWeight','bold','Interpreter','Latex');
	end
end

