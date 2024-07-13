load('data/matlab_syn_data.mat')

x = x';
t = t';
new_x = x(1:8000);
new_y = y(1:8000);
new_t = t(1:8000);

subplot(2,1,1)
plot(new_t,new_x(:))
ylabel('Force (N)')
subplot(2,1,2)
plot(new_t,new_y(:))
ylabel('Displacement (m)')
xlabel('Time (s)')



hold on;

clf
winlen = size(new_x, 1);
modalfrf(new_x(:),new_y(:),fs,winlen,'Sensor', 'dis')