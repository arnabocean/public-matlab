
%    do_Bsl_Cwt_Energy. Script to loop through series of data files and
%                       perform various numerical analyses.
%
%    Inputs:
%
%            - None, although some parameters may be changed 
%              from within the script, as described below:
%    
%               - search criterion to identify files to work upon
%               - Bessel filter parameters.
%               - Continuous Wavelet Transform variables
%               - Misc. parameters for data file handling.
%    
%    Outputs:
%
%            - A series of data files are written to disk, each 
%              containing the following data from *each* file analysed:
%    
%               - File Number (continuing between all files)
%               - Freq. corresponding to max. amplitude (Hz)
%               - Time corresponding to max. amplitude (index number)
%               - Centroidal Frequency (Hz)
%               - Wavelet amplitude (raw number)
%    
%               The files written are of the form CwtEnergy_Comp01, 02, etc.
%    
%    Other m-files required: getBessel.m, getCWT.m, stripFileString.m, 
%                            replaceWaveletFreq.m.
%    Sub-functions required: None.
%    MAT-files required: None.
%
%    See also: besselfilter.m.

%    License:       Please see license.txt in the same repository. 
%                   In short, this code uses the MIT license: 
%                   http://opensource.org/licenses/MIT




%    Author:            Arnab Gupta
%                       Ph.D. Candidate, Virginia Tech.
%                       Blacksburg, VA.
%    Website:           http://arnabocean.com
%    Repository         http://bitbucket.org/arnabocean
%    Email:             arnab@arnabocean.com
%
%    Version:           1.01
%    Last Revised:      Sat Dec 14 21:24:43 2013
%
%    Changelog:
%   
%    Reordered code sections so that all sections where 
%       parameters may be changed are organized at top 
%       of the file.
%    
%    Added documentation and author information.
%        
    
    
        



%% Change the parameters in this section:

%  Extension
ext = '*.raw.txt';

%  Variables
strbegin = 4;                   % # of characters at beginning of filestr to ignore
strend = 2;                     % # of characters at end of filestr to ignore
flwhich_array = ['01';'02'];    % access using flwhich_array(1,:)
szwhich = size(flwhich_array);

% Bessel Variables
order = 4;
low = 50*10^3;		%	50kHz;
high = 1000*10^3;	%	1000kHz = 1MHz;
sampling = 25*10^6;	%	25MHz;

% CWT Variables
scalestart = 5;
scaleinc = 5;	% 20
scaleend = 1500;

wvlt = 'morl';
scales = scalestart: scaleinc: scaleend;
timescale = 1/sampling;  % 40ns = 25MHz sampling rate
freqscale = 1.5*scal2frq(scales,wvlt,timescale);    %   Needs wavelet toolbox

clear scalestart scaleend scaleinc

%%  Import filenames

files = dir(fullfile(ext));

filename = {files(:).name}';
szfile = size(filename);

clear files;


%% Create variables for saving values 

varCol1 = zeros(szfile(1)/szwhich(1),1);            %   Col1 = file number (starts at 0). Shared between all output files.
varCol2 = zeros(szfile(1)/szwhich(1),szwhich(1));   %   Col2 = Freq for max amplitude (wavelet, then convert to Hz). Separate for each output.
varCol3 = zeros(szfile(1)/szwhich(1),szwhich(1));   %   Col3 = Time for max amplitude (Index number). Separate for each output.
varCol4 = zeros(szfile(1)/szwhich(1),szwhich(1));   %   Col4 = Centroid Freq (Converted to Hz). Separate for each output.
varCol5 = zeros(szfile(1)/szwhich(1),szwhich(1));   %   Col5 = wavelet amplitude (raw number). Separate for each output.

varsave = zeros(szfile(1)/szwhich(1), 5);   %   This is the final variable used to save to disk

%%  Iteration value

% i = 10;

%%  Loop!

for i = 1: szfile(1)
    
    %%  Import Raw Data
    
%     disp(i);
    filestr = filename{i,1};
    in = importdata(filestr);
    [~, flname, ~] = fileparts(filestr);
    
    
    %%  Bessel Filter
    
    bsldata = getBessel(in,'',order,low,high,sampling);
    
    %% CWT computations
    
    [cw1, SC] = getCWT(bsldata,scales,wvlt,'');
    
    % Scale as percentage of total energy
    %     SC = 100*SC./sum(SC(:));
    
    %% Max Energy
    
    maxEn = max(max(SC));
    
    [freqMax, timeMax] = find(SC==maxEn,1,'first');
    
    %% Frequency Centroid for Max Energy
    
    % Formula for FreqCentroid = Sum(amp(i)*freq(i)) / Sum(amp(i))
    freqCentroid = sum(SC(:,timeMax).*freqscale(:))/sum(SC(:,timeMax));
    
    %% Parse filename for which component
    
    stripflname = stripFileString(flname);      % remove ALL file extensions.
    flmaxlen = length(stripflname)-strend+1;    % # of characters at end of FileID
    
    whichComponent = stripflname(flmaxlen:length(stripflname)); % Get last few characters that define component
    
    %%  Assign to variables
    for k = 1: szwhich(1)
        
        if strcmp(flwhich_array(k,:),whichComponent)
            diffForCompleteCycle = szwhich(1)-k;    % Cycle => cycle of consecutive components
            jj = (i+diffForCompleteCycle)/szwhich(1);
            
            varCol1(jj,1) = str2double(stripflname(strbegin+1:flmaxlen-1));
            varCol2(jj,k) = freqMax;
            varCol3(jj,k) = timeMax;
            varCol4(jj,k) = freqCentroid;
            varCol5(jj,k) = maxEn;
        end
    end
end

%% Clear all but necessary variables

clearvars -except szwhich varCol* varsave freqscale timescale flwhich_array wvlt

%%  Save variables to disk

for k = 1: szwhich(1)
    varsave(:,1) = varCol1(:,1);                                % file ID
    varsave(:,2) = replaceWaveletFreq(varCol2(:,k),freqscale);  % Hz
    varsave(:,3) = (varCol3(:,k)-1)*timescale;                  % seconds  
    varsave(:,4) = varCol4(:,k);                                % Hz
    varsave(:,5) = varCol5(:,k);                                % raw number.
    
    save(strcat('CwtEnergy_Comp',flwhich_array(k,:),'.',wvlt,'.txt'), '-ascii','-double','-tabs', 'varsave');
end
    
    
