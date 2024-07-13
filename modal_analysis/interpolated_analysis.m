accelerations = readtable('dataset1/acceleration3axces.xlsx');
impulse_data = readtable('dataset1/interpolated_input.xlsx');
time_avg_data = readtable('dataset1/time-avg-input.xlsx');

data= table2array(accelerations);
impulse= table2array(impulse_data);
time_avg= table2array(time_avg_data);

axisX = data(:, 1);
axisY = data(:, 2);
axisZ = data(:, 3);

impulse_fft = fft(impulse);

figure;
subplot(2, 1, 1);
plot(time_avg(:, 1), time_avg(:, 3));
title('Input Impulse Function');
xlabel('Time');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(time_avg(:, 1), time_avg(:, 2));
title('Output Acceleration');
xlabel('Time');
ylabel('Amplitude');