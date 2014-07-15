function prettyPlot(figHandle,fontNameList,fontSizeList,textBoxCell,toprghtText)

%%	Initialize
if nargin == 0
	error('Too few arguments. Figure handle required.');
elseif nargin > 5
	error('Too many arguments. Use help prettyPlot.');
end

if ~exist('fontSizeList','var')
% 	fontSizeList = [16; 16; 16];	% [title; axes; all other]
    fontSizeList = [16; 12; 12];	% [title; axes; all other]
end

if ~exist('fontNameList','var')
	if ismac
		fontNameList = {'Foglihten','Consolas','Consolas'};
		fontNameList = {'Avenir','Avenir','Avenir'};
	elseif ispc
		fontNameList = {'Palatino','Candara','Constantia'};
	end
end

%%	

set(findall(gcf,'type','text'),'FontSize',fontSizeList(3),'FontName',fontNameList{3},'FontWeight','bold');
set(gca,'FontSize',fontSizeList(2),'FontName',fontNameList{2},'FontWeight','bold');

set(get(gca,'Title'),'FontSize',fontSizeList(1),'FontName',fontNameList{1},'FontWeight','bold');

%%	Optional Code, normally commented out, use as necessary

%%	Text boxes at bottom right and top right

% H = text(1.02, 0.0, textBoxCell, 'VerticalAlignment', 'bottom', ...
%      'HorizontalAlignment', 'left', ...
%      'Units', 'normalized');
% drawnow;

% H = text(0.99, 0.99, strcat(toprghtText,'\rightarrow'), 'VerticalAlignment', 'top', ...
%      'HorizontalAlignment', 'right', ...
%      'Units', 'normalized');
% drawnow;
