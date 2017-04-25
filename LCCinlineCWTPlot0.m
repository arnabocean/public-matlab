function LCCinlineCWTPlot0(cw1,scales,wvlt,flname)

	szdata = size(cw1);

	SC = abs(cw1.*cw1);
	SC = 100*SC./sum(SC(:));

	szSC = size(SC);

	freqscale = 1.5*scal2frq(scales,wvlt,4E-8);
	freqscale = flipdim(freqscale,2)/1000;
	xpoints = 0: 40E-3: (szSC(2)-1)*40E-3;


	fig1 = figure('Visible','off');
	axes1 = axes('Parent',fig1,'FontSize',14);

	% [X,Y] = meshgrid(xpoints,freqscale);
	% contour(X,Y,SC,200);
	contour(xpoints,freqscale,SC,100);

	xlabel('Time (\mus)','FontSize',14);
	ylabel('Frequency (kHz)','FontSize',14);
	title(char(strcat({'Continous Wavelet Transform using '},{wvlt})),'FontSize',16);
	grid on;

	colormax0 = 30E-3; %10E-3;
	colormax1 = 60E-3;%20E-3;
	colormax2 = 80E-3;%30E-3;
	if max(max(SC)) >= colormax2
	    colormap winter;
	    colormap(flipud(colormap))
	elseif max(max(SC)) >= colormax1
	    colormap summer;
	    colormap(flipud(colormap))
	    caxis([0 colormax2]);
	elseif max(max(SC)) >= colormax0
	    colormap jet;
	    caxis([0 colormax1]);
	else
	    colormap jet;
	    caxis([0 colormax0]);
	end
	colorbar;
	ylim([floor(freqscale(1)) 1100]);

	figtype = 'png';
	orient landscape;
	saveas(fig1, strcat(flname,'.',figtype));
	close(fig1);

	clearvars 
