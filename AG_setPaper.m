function AG_setPaper(ppsize,axpos)


%   AG_setPaper. Set dimensions of paper and position of axes on paper for figure printing / saving.
%
%   Inputs:
%
%      - ppsize: 4-element array as [x1, y1, x2, y2], where x1,y1 => bottom left coordinates; x2=>x-length of paper; y2=>y-length of paper.
%      - axpos: 4-element array as [x1, y1, x2, y2], where x1,y1 => bottom left coordinates; x2=>x-length of axis; y2=>y-length of axis.
%
%   Outputs:
%
%      - None
%
%   Other m-files required: prettyPlot.m, which sets the typeface and font size of the figure elements.
%   Sub-functions required: None.
%   MAT-files required: None.
%
%   See also: prettyPlot.m.


%   Author:         Arnab Gupta
%                   Ph.D. Candidate, Virginia Tech.
%                   Blacksburg, VA.
%   Website:        http://arnabocean.com
%   Repository:     http://bitbucket.org/arnabocean
%   Email:          arnab@arnabocean.com
%
%   Version:        1.0
%   Last Revised:   3 March 2016
%
%   Changelog:
%		3 March 2016: Create code. Refer to http://stackoverflow.com/questions/3600945/printing-a-matlab-plot-in-exact-dimensions-on-paper
%      




%%
if ~exist('ppsize','var')
	ppsize = [0 0 11 8.5];
end

if ~exist('axpos','var')
% 	axpos = [0.06 0.07 0.9 0.88];
    axpos = [0.06 0.07 0.9 0.88];
end

%%
set(gcf,'Units','inches','Position',ppsize);
set(gca,'Position',axpos);

orient landscape;
prettyPlot;
