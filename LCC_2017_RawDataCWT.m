%	From matlab2017_RAWtoCWT.pbs

pobj = parpool(8);

%%	Add path where matlab repo is maintained

addpath('/home/arnab/workspace/matlab/repoclones/bbpublicmatlab',path);
%%

trgtfldr = 'rawdata';
if ~exist(trgtfldr,'dir')
	system(sprintf('tar -xzvf %s.tar.gz',trgtfldr));
	system(sprintf('rm %s/._*.txt',trgtfldr));
end
cd(trgtfldr);

%%
copyfile('/home/arnab/workspace/matlab/repoclones/bbpublicmatlab/get_AllCWT_2017.m','.');

get_AllCWT_2017('*.raw.txt','*.wlt.mat');

delete pobj