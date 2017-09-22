%addpath(strcat('/Users/sivaven/Projects/CARLsim3.1/projects/chaos/results/',folder));
NM = NetworkMonitor('results_1000I_cp/sim_chaos.dat');
SR = SpikeReader('results_0I_cp/spk_PSTUT.dat');

binWindow=80;
n=6
nrns=[52 53 54 55 56 57]
spkData = SR.readSpikes(binWindow); % binWindowMs
pop=zeros(24)

for i=1:n
pop = pop + spkData(40:63 ,nrns(i));
end

nrn1 = spkData(40:63 ,nrns(4));

pop = (pop*1000)/(n*binWindow)
nrn1 = nrn1*1000/(n*binWindow)
%plot();hold on;
%plot(pop);hold on; plot(nrn1);

NM.plot([3], 1000); 

%clear
