function [outdata, b, a] = getBessel(rawdata,flname,order,low,high,sampling)

%	Function to process input data and obtain bessel filtered output data.
%	
%	Input:
%	
%		rawdata:	Input data to be filtered. Data should comprise
%					columns of data. If there are more than one
%					columns, it is assumed that the *last* column
%					contains the data of interest, and the *first*
%					column contains timestamp values. Other columns,
%					if any, are ignored.
%	
%		flname:		string to be used to save the output to disk. 
%					If saving to disk is NOT required, use flname = ''.
%	
%	
%		order:		Order of Bessel Filter, as a scalar numeric.
%		low:		Lower bound of bandpass filter, in Hz.
%		high:		Upper bound of bandpass filter, in Hz.
%		sampling:	Sampling frequency, in Hz.
%	
%	Output:
%	
%		outdata:	Output matrix of filtered data
%		b, a:		Bessel filter transfer function constants
%		
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
%	Last Revised:	Sat Dec 14 23:06:17 2013
%
%	Changelog:
%	
%	Updated documentation.
%	Cleaned up code.
%		


%%	Default values
def_order = 4;
def_low = 50*10^3;	% 50kHz
def_high = 1*10^6;  % 1MHz
def_sampling = 25*10^6; % 25MHz
def_flname = '';

%%	Use default values if enough input arguments are not supplied

if nargin > 6
	error('Too many arguments');
elseif nargin == 0
	error('Too few arguments');
end

if ~exist('sampling', 'var')
	sampling = def_sampling;
end

if ~exist('high', 'var')
	high = def_high;
end

if ~exist('low', 'var')
	low = def_low;
end

if ~exist('order', 'var')
	order = def_order;
end
if ~exist('flname', 'var')
	flname = def_flname;
end


if ~isnumeric(rawdata) || ~isnumeric(order) || ~isnumeric(low) || ~isnumeric(high) || ~isnumeric(sampling)
	error('Incorrect input data type.')
end

%%

[outdata(:,1), b, a] = besselfilter(order,low,high,sampling,rawdata(:,end));

if size(rawdata,2) > 1
	outdata(:,2) = outdata(:,1);
	outdata(:,1) = rawdata(:,1);
end

%%

if ~strcmp(flname,'')
	save(strcat(flname,'.bsl.txt'),'-ascii','-double','-tabs','outdata');
end

%%
clearvars -except outdata b a
