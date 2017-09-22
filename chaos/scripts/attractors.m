
SR = SpikeReader('results/spk_PSTUT.dat');
spkData= SR.readSpikes(25); 

sd1 = spkData(100:150,80);
sd2 = spkData(100:150,83);
plot(sd1, sd2, 'x');
%plot(sd1, sd2);