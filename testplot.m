

test_fft_algorithm;
title('FFT of created signal');
set(get(gca,'XLabel'),'String','Frequency (Hz)');
set(get(gca,'YLabel'),'String','Amplitude');
legend('FFT values','Location','NorthEastOutside');

prettyPlot(2);

