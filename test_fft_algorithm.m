
%% Prepare parameters to create test signal

f = [2 5 13 11 7 23];	% frequencies (Hz)
A = [2 5 3   9 6 11];	% Amplitudes

w = 2*pi*f;	%	Radial frequencies omega = 2*pi*f

%% Create and plot test signal based on parameters above

t = 0: 0.01: 10; 	%	10 seconds, sampled at 100Hz. => Nyquist freq = 50Hz.

for k = 1: length(f)
	xx(:,k) = A(k)*sin(w(k)*t);		%	Create each individual signal component
end

x = zeros(size(xx,1),1);			%	Variable for combined signal
for k = 1: size(xx,2)

	x(:,1) = x(:,1) + xx(:,k);		%	Add each component to combined signal.
end

x = x + 2;	%	Add bias

fH1 = figure; plot(t,x); grid on;

%% Perform FFT and plot based on created signal

NN = length(x); TT = t(end)-t(1);f0=1/TT;
freq = 0:f0:(NN-1)*f0;

datavg = mean(x);					%	Remove bias
x = x - datavg;

dat(:,1) = freq;
dat(:,2) = abs(fft(x))*2/NN;		%	Actual FFT function call. 2/NN is the scaling factor to get the amplitude right.

dat1(:,1) = dat(1:ceil(length(dat)/2),1);	%	Remove everything above Nyquist Frequency (half of max frequency)
dat1(:,2) = dat(1:ceil(length(dat)/2),2);

fH2 = figure; plot(dat1(:,1),dat1(:,2));
grid on;

%%

figure(fH2);
title('FFT of created signal');
set(get(gca,'XLabel'),'String','Frequency (Hz)');
set(get(gca,'YLabel'),'String','Amplitude');
% legend('FFT values','Location','NorthEastOutside');
legend('FFT values','Location','NorthEast');

xlm = get(gca,'xlim');
set(gca,'XTick',0:2:max(xlm));

ylm = get(gca,'ylim');
set(gca,'YTick',0:2:max(ylm));

prettyPlot;


%%

freqList = f';
ampList = A';

%%

clear f A w t k xx x
clear NN TT f0 freq datavg dat dat1