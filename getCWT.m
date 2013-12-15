function [cwtOUT, SC] = getCWT(in,scales,wvlt,flname)


%	getCWT. Function to compute the Continuous Wavelet Transform
%			and flipud() the output for better usability.
%
%	Inputs:
%
%			- in:	Input data to be filtered. Data should comprise
%					columns of data. If there are more than one
%					columns, it is assumed that the *last* column
%					contains the data of interest, and other columns,
%					if any, are ignored.
%			- scales:	numeric array required as input to cwt()
%			- wvlt:		string value of wavelet type, example 'morl'
%						for Morlet Wavelet.
%			
%			-flname: 	string to be used to save the output to disk. 
%						If saving to disk is NOT required, use flname = ''.
%
%	Outputs:
%
%			- cwtOUT:	Matrix of CWT coefficients, 
%					 	after performing flipud() on it.
%			- SC:	  	Scalogram energy calculation, without scaling
%						as percentage of total energy.
%						To perform such scaling, the following must be
%						done: SC = 100*SC./sum(SC(:));
%
%	Other m-files required: None.
%	Sub-functions required: None.
%	MAT-files required: None.
%
%	See also: None.
%
%    License:       Please see license.txt in the same repository. 
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
%	Last Revised:	Sat Dec 14 23:31:49 2013
%
%	Changelog:
%
%		

%% default values

% CWT Variables
scalestart = 5;
scaleinc = 5;	% 20
scaleend = 1500;

def_wvlt = 'morl';
def_scales = scalestart: scaleinc: scaleend;
def_flname = '';

clear scalestart scaleend scaleinc

%% Error checking

if ~exist('scales', 'var')
	scales = def_scales;
end

if ~exist('wvlt', 'var')
	wvlt = def_wvlt;
end

if ~exist('flname', 'var')
	flname = def_flname;
end

if ~isnumeric(in) || ~isnumeric(scales) || ~ischar(wvlt) || ~ischar(flname)
	error('Incorrect argument format.');
end

%%

cwtOUT = cwt(in(:,end),scales,wvlt);
cwtOUT = flipud(cwtOUT);

SC = abs(cwtOUT.*cwtOUT);

%%

if ~strcmp(flname,'')
    save(strcat('cwt',upper(wvlt),'_',flname,'.wlt.mat'),'cwtOUT','scales','wvlt');
end
clearvars -except cwtOUT SC
