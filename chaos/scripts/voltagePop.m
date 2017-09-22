

n=5
nrns=[10 11 12 13 14]%[52 53 54 55 56 57]%
foc=3

v=zeros(4100,n);

for i=1:n
filename=strcat('results/grp_pstut_',num2str(nrns(i)));
fid = fopen(filename,'r');
v(:,i) = fscanf(fid,'%f;');
fclose(fid);
end

totv = zeros(4100, 1);
for i=1:n
totv(:, 1) = totv(:, 1) + v(:,i)
end
totv(:, 1) = totv(:, 1)/n

g=gausswin(10);
g=g/sum(g);
totv_filt = conv(totv(:, 1), g, 'same');

xmin1=1900
xmax1=2000
xmin2=2000
xmax2=2100
xmin3=3900
xmax3=4000


lims1b = [xmin1, xmax1, -40, -20]

lims2b = [xmin2, xmax2, -40, -20]

lims3b = [xmin3, xmax3, -40, -20]
%1st column

subplot(3,3,1)
plot(totv, 'LineWidth', 1); hold on; plot(totv_filt, 'LineWidth', 1.5,   'Color', [0, 0, 0])
axis(lims1b)

subplot(3,3,4)
v2_filt = conv(v(:, foc), g, 'same');
plot(v(:, foc), 'LineWidth', 1); hold on; plot(v2_filt, 'LineWidth', 1,  'Color', [0.6, 0, 0]);
axis(lims1b)
ylabel('V (mV)')

subplot(3,3,7)
plot(v2_filt, 'LineWidth', 1, 'Color', [0.6, 0, 0]); hold on; plot(totv_filt, 'LineWidth', 1.5, 'Color', [0, 0, 0]);
axis(lims1b)
xlabel('Time (ms)')

%2nd column
subplot(3,3,2)
plot(totv, 'LineWidth', 1); hold on; plot(totv_filt, 'LineWidth', 1.5, 'Color', [0, 0, 0])
axis(lims2b)

subplot(3,3,5)
v2_filt = conv(v(:, foc), g, 'same');
plot(v(:, foc), 'LineWidth', 1); hold on; plot(v2_filt, 'LineWidth', 1,  'Color', [0.6, 0, 0]);
axis(lims2b)

subplot(3,3,8)
plot(v2_filt, 'LineWidth', 1, 'Color', [0.6, 0, 0]); hold on; plot(totv_filt, 'LineWidth', 1.5, 'Color', [0, 0, 0]);
axis(lims2b)
xlabel('Time (ms)')

%3rd column
subplot(3,3,3)
plot(totv, 'LineWidth', 1, 'DisplayName','subGroup avg. (neurons 52 thru 57)'); 
hold on; 
plot(totv_filt, 'LineWidth', 1.5, 'Color', [0, 0, 0], 'DisplayName', 'smoothed')
axis(lims3b)
legend('show')

subplot(3,3,6)
v2_filt = conv(v(:, foc), g, 'same');
plot(v(:, foc), 'LineWidth', 1, 'DisplayName', strcat('neuron-',num2str(nrns(foc)))); 
hold on; 
plot(v2_filt, 'LineWidth', 1,  'Color', [0.6, 0, 0], 'DisplayName', 'smoothed');
axis(lims3b)
legend('show')

subplot(3,3,9)
plot(v2_filt, 'LineWidth', 1, 'Color', [0.6, 0, 0], 'DisplayName', strcat('neuron-',num2str(nrns(foc)))); 
hold on; 
plot(totv_filt, 'LineWidth', 1.5, 'Color', [0, 0, 0],  'DisplayName','subGroup avg. (neurons 52 thru 57)');
axis(lims3b)
xlabel('Time (ms)')
legend('show')
