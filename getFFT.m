function dat1 = getFFT(in,filename, startfreq)


%    getFFT. Function to compute the FFT of a data signal
%            contained in a single file, and to optionally
%            write the FFT computed data to disk
%
%    Inputs:
%
%            - in: Input data vector of the form in(nn,2),
%                  where 'nn' is the length of the data.
%                  Column 1 => Time (s)
%                  Column 2 => Amplitude (V)
%            - filename: Optional filename to be used to 
%                        write FFT to disk. The extension
%                        '.raw.fft' will be appended to the
%                        end of the raw filename.
%            - startfreq: Optional value to offset to the 
%                         starting point of the frequency
%                         scale (e.g. where it is known that
%                         the first frequency in the data is
%                         not zero but an offset value.)
%
%    Outputs:
%
%            - dat1: Computed FFT data, of the form dat1(nn,2),
%                    where 'nn' is the length of the data.
%                    Column 1 => Freq (Hz)
%                    Column 2 => FFT Amplitude (raw number)
%   
%    Note: Performance of the code (especially whether the 
%    computed data is scaled correctly) can be tested from the
%    script test_fft_algorithm.m, which creates an artificial
%    signal comprising multiple sinusoids, then finds their FFT.
%    
%    Other m-files required: stripFileString.m, test_fft_algorithm.m.
%    Sub-functions required: None.
%    MAT-files required: None.
%
%    See also: stripFileString.m, test_fft_algorithm.m.

%    Author:            Arnab Gupta
%                       Ph.D. Candidate, Virginia Tech.
%                       Blacksburg, VA.
%    Website:           http://arnabocean.com
%    Repository         http://bitbucket.org/arnabocean
%    Email:             arnab@arnabocean.com
%
%    Version:           1.1
%    Last Revised:      Mon Dec 23 23:17:57 2013
%
%    Changelog:
%
%        Updated documentation.
%        Added call to stripFileString to improve naming of file when writing to disk.



%% Initialize

if ~exist('startfreq','var')
    startfreq = 0;
end

%%  Set up

N = length(in);         %   Length of vector
T = in(N)-in(1);        %   Total time
f0 = 1/T;               %   therefore, frequency unit

%%  Remove bias

avg = mean(in(:,2));
in(:,2) = in(:,2) - avg;

%%  Setup frequency scale, with offset if specified

freq = startfreq: f0: (N-1)*f0;     

%%  Computation

clear dat;
dat(:,1) = freq;
dat(:,2) = abs(fft(in(:,2)))*2/N;

dat1(:,1) = dat(1:ceil(length(dat)/2),1);
dat1(:,2) = dat(1:ceil(length(dat)/2),2);

%% Write to disk, if filename is provided

if ~exist('filename','var') || isempty(filename)
    clearvars -except dat1
    return;
end


[~, flname, ~] = fileparts(filename);
flname = stripFileString(flname);

save(strcat(flname,'.raw.fft.txt'),'-ascii','-double','-tabs','dat1');

%% Clear variables

clearvars -except dat1
