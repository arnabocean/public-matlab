function figtype = plotCWT(filename)

%	Function to plot figure based on the output of
%	Matlab's Continuous Wavelet Transform function.
%	Instead of using Matlab's wavelet toolbox function
%	scalogram, this computes the relevant quantities 
%	and uses a contour function. This makes the plot
%	features easier to control and customize.
%	
%	This replaces an earlier version which uses Matlab's
%	scalogram function. Inputs and outputs remain the same
%	from the older version of the function.
%	
%	Since my home computer does not have the wavelet toolbox,
%	I've hardcoded the frequency scales obtained using the
%	Matlab function scal2frq as following:
%		freqscale = scal2frq(scales,wvlt,4E-8);
%	
%	The current frequency scale is not assured to be perfectly
%	accurate; however the behavior of the specimen should be 
%	independent of the labels on the frequency axis.
%	
%	Currently, the following is used:
%		freqaxis = scal2frq(1:75,'mexh',4E-8);
%	The lowerbound frequency (83kHz) is almost certainly wrong.

%	Author:		Arnab Gupta
%	Date:		12/01/12 20:34:59
%	Version:	2.0


	in = importdata(filename);

	data = in.cw1;

	scales = in.scales;
	wvlt = in.wvlt;

	clear in;

	szdata = size(data);

	SC = abs(data.*data);
	SC = 100*SC./sum(SC(:));

	szSC = size(SC);

	% ypoints = freqscale;
	freqscale = scal2frq(scales,wvlt,4E-8);
	freqscale = flipdim(freqscale,2)/1000;
	xpoints = 0: 40E-3: (szSC(2)-1)*40E-3;

	[X,Y] = meshgrid(xpoints,freqscale);

	fig1 = figure('Visible','off');
	axes1 = axes('Parent',fig1,'FontSize',14);

	contour(X,Y,SC,100);

	
	% colormax = 1.60E-3;
	colormax1 = 20E-3;
	colormax2 = 30E-3;
	if max(max(SC)) >= colormax2
		colormap cool;
		ylim([floor(freqscale(1)) 200]);

	elseif max(max(SC)) >= colormax1
		colormap summer;
		caxis([0 colormax2]);
		ylim([floor(freqscale(1)) 200]);

	else
		colormap jet;
		caxis([0 colormax1]);
		ylim([floor(freqscale(1)) 150]);

		% colormap jet;
	end

	xlabel('Time (\mus)','FontSize',14);
	ylabel('Frequency (kHz)','FontSize',14);
	title(char(strcat({'Continous Wavelet Transform using '},{wvlt})),'FontSize',16);
	colorbar;

	[pathstr flname flext] = fileparts(filename);
	figtype = 'png';
	orient landscape;
	saveas(fig1, strcat(flname,'.',figtype));
	close(fig1);

	clearvars -except figtype
