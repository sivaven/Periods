folder ='0b';
nrn1='100';
nrn2='551';
addpath(strcat('/Users/sivaven/Projects/CARLsim3.1/projects/chaos/results/',folder));
filename1=strcat(folder,'/grp_fs_',nrn1,'.v');
fid = fopen(filename1,'r');
v_fs_1 = fscanf(fid,'%f;');
fclose(fid);

filename2=strcat(folder,'/grp_fs_',nrn2,'.v');
fid = fopen(filename2,'r');
v_fs_2 = fscanf(fid,'%f;');
fclose(fid);

filename3=strcat(folder,'/grp_pstut_',nrn1,'.v');
fid = fopen(filename3,'r');
v_pstut_1 = fscanf(fid,'%f;');
fclose(fid);

filename4=strcat(folder,'/grp_pstut_',nrn2,'.v');
fid = fopen(filename4,'r');
v_pstut_2 = fscanf(fid,'%f;');
fclose(fid);

minx = 1000
maxx = 1999
%v_fs_0=v_fs_0 - v_fs_0(1)
%v_fs_500=v_fs_500 - v_fs_500(1)
subplot(4,2,1);
plot(v_fs_1(minx:maxx));title('fs-0');
subplot(4,2,2);
plot(v_pstut_1(minx:maxx));title('pstut-0');

subplot(4,2,3);
plot(v_fs_2(minx:maxx));title('fs-100');

subplot(4,2,4);
plot(v_pstut_2(minx:maxx));title('pstut-100');
%
% phases
%
v_fs_0_hlbt=hilbert(v_fs_1(minx:maxx));
len=maxx-minx+1;
phase_fs_0 = zeros(len,1);
for i=0:len-1
phase_fs_0(i+1)=atan(v_fs_0_hlbt(i+1)/v_fs_1(minx+i));
end

v_fs_100_hlbt=hilbert(v_fs_2(minx:maxx));
len=maxx-minx+1;
phase_fs_100 = zeros(len,1);
for i=0:len-1
phase_fs_100(i+1)=atan(v_fs_100_hlbt(i+1)/v_fs_2(minx+i));
end

v_pstut_0_hlbt=hilbert(v_pstut_1(minx:maxx));
len=maxx-minx+1;
phase_pstut_0 = zeros(len,1);
for i=0:len-1
phase_pstut_0(i+1)=atan(v_pstut_0_hlbt(i+1)/v_pstut_1(minx+i));
end

v_pstut_100_hlbt=hilbert(v_pstut_2(minx:maxx));
len=maxx-minx+1;
phase_pstut_100 = zeros(len,1);
for i=0:len-1
phase_pstut_100(i+1)=atan(v_pstut_100_hlbt(i+1)/v_pstut_2(minx+i));
end

fs_phase_difference = angle(phase_fs_0) - angle(phase_fs_100);
subplot(4,2,5);
%plot(v_fs_0(minx:maxx), v_fs_100(minx:maxx));title('fs0&100');
plot(fs_phase_difference);%, abs(phase_fs_0));

subplot(4,2,7);
polarplot(fs_phase_difference, ones(maxx-minx+1, 1),'-');

pstut_phase_difference = angle(phase_pstut_0) - angle(phase_pstut_100);
subplot(4,2,6);
%plot(v_fs_0(minx:maxx), v_fs_100(minx:maxx));title('fs0&100');
plot(pstut_phase_difference);%, abs(phase_fs_0));

subplot(4,2,8);
polarplot(pstut_phase_difference, ones(maxx-minx+1, 1));

%plot(v_pstut_0(minx:maxx), v_pstut_100(minx:maxx), '.');title('pstut0&100');
%plot(v_fs_100(1:500));
%plot(v_pstut_0(1:500));
%plot(v_pstut_100(1:500));

%clear;