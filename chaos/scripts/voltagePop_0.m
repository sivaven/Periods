

n=6
nrns=[52 53 54 55 56 57]%[17 18 19 20]%
foc=1

v=zeros(4100,n);

for i=1:n
filename=strcat('results_0I_cp/grp_pstut_',num2str(nrns(i)));
fid = fopen(filename,'r');
v(:,i) = fscanf(fid,'%f;');
fclose(fid);
end

totv = zeros(4100, 1);
for i=1:n
totv(:, 1) = totv(:, 1) + v(:,i)
end
totv(:, 1) = totv(:, 1)/n

g=gausswin(50);
g=g/sum(g);
totv_filt = conv(totv(:, 1), g, 'same');

xmin1=2000
xmax1=3000

lims1 = [xmin1, xmax1, -80, 20]
lims1b = [xmin1, xmax1, -60, -40]

%1st column

subplot(3,1,1)
plot(totv, 'LineWidth', 1, 'DisplayName','subGroup avg. (neurons 52 thru 57)'); hold on; plot(totv_filt, 'LineWidth', 1.5,  'DisplayName', 'Smoothed', 'Color', [0, 0, 0])
axis(lims1b)
legend('show')

subplot(3,1,2)
v2_filt = conv(v(:, foc), g, 'same');
plot(v(:, foc), 'LineWidth', 1, 'DisplayName', strcat('neuron-',num2str(nrns(foc)))); hold on; plot(v2_filt, 'LineWidth', 1, 'DisplayName','Smoothed', 'Color', [0.6, 0, 0]);
axis(lims1b)
ylabel('V (mV)')
legend('show')

subplot(3,1,3)
plot(v2_filt, 'LineWidth', 1, 'Color', [0.6, 0, 0], 'DisplayName', strcat('neuron-',num2str(nrns(foc)))); hold on; plot(totv_filt, 'LineWidth', 1.5, 'Color', [0, 0, 0], 'DisplayName', 'subGroup avg. (neurons 52 thru 57)');
axis(lims1b)
xlabel('Time (ms)')
legend('show')