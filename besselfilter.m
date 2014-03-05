function [filtData, b, a] = besselfilter(order,low,high,sampling,data)

%   besselfilter. Function to implement a bandpass Bessel Filter.
%    
%   [filtData, b, a] = besselfilter(order,low,high,sampling,data)
%   
%   Inputs:
%    
%       order:      Number of poles in the filter. Scalar numeric value.
%                     Eg.: 4
%       low:        Lower frequency bound (Hz). Scalar numeric value.
%                     Eg.: 50000 (= 50kHz)
%       high:       Upper frequency bound (Hz). Scalar numeric value.
%                     Eg.: 1000000 (= 1MHz)
%       sampling:   Sampling frequency (Hz). Scalar numeric value.
%                     Eg.: 25000000 (= 25MHz)
%       data:       Input data. Numeric vector.
%                     Eg.: data vector of size (n x 1)
%    
%   Output:
%    
%       filtData:   Output filtered data. Numeric vector.
%                     Eg.: data vector of size (n x 1)
%       b, a:       Transfer function values for the filter. Scalar numeric.
%    
%    License:       Please see license.txt in the same repository. 
%                   In short, this code uses the MIT license: 
%                   http://opensource.org/licenses/MIT


%    Author:         Arnab Gupta
%                    Ph.D. Candidate, Virginia Tech.
%                    Blacksburg, VA.
%    Website:        http://arnabocean.com
%    Repository:     http://bitbucket.org/arnabocean
%    Email:          arnab@arnabocean.com
%
%    Version:        1.0
%    Last Revised:   Thu Dec 12, 2013
%
%    Changelog:
%    
%       Tue Mar  4, 2014: Updated documentation, removed old commented out lines from code.
%
%        


%%  Create lowpass filter

%   Zeros, poles and gain. 'z' is empty since there are no zeros.
[z,p,k] = besselap(order);

%   Convert to transfer function form
[A,B,C,D] = zp2ss(z,p,k);

%%  Bandpass filter calculations

%   Lower and upper bounds for bandpass filter
wlow = low*2*pi;
whigh = high*2*pi;

%   Bandpass filter parameters
Bw = whigh-wlow;
Wo = sqrt(wlow*whigh);

%%  Convert lowpass filter to bandpass filter

%   Convert a lowpass filter to bandpass filter, in statespace form
[At,Bt,Ct,Dt] = lp2bp(A,B,C,D,Wo,Bw);

%   Convert statespace form to transfer function form
[b,a] = ss2tf(At,Bt,Ct,Dt);

%   Create transfer function parameters for bandpass filter
[Ad,Bd,Cd,Dd] = bilinear (At,Bt,Ct,Dt,sampling,low);
[bz,az] = ss2tf(Ad,Bd,Cd,Dd);

%%  Clean-up

b = bz;
a = az;

%%  Convert data

for i = 1:length(data)
    
    y(i)=b(1)*data(i);
    for j = 1:length(b)-1
        if (i-j)>0
            y(i)=y(i)+b(j+1)*data(i-j)-a(j+1)*y(i-j);
        end
    end

end

%%  Save variables

filtData = y;

clearvars -except filtData b a