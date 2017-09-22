nrn1='55';
nrn2='56';

filename=strcat('results/grp_pstut_',nrn1);
fid = fopen(filename,'r');
v1 = fscanf(fid,'%f;');
fclose(fid);

filename=strcat('results/grp_pstut_',nrn2);
fid = fopen(filename,'r');
v2 = fscanf(fid,'%f;');
fclose(fid);

b = 1600
e = 2000

subplot(2,1,1)
plot(v1(b:e));hold on; plot(v2(b:e));
subplot(2,1,2)
plot(v1(b:e),v2(b:e) )