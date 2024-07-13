accelerations = readtable('dataset1/acceleration3axces.xlsx');
impulse_data = readtable('dataset1/interpolated_input.xlsx');
time_avg_data = readtable('dataset1/time-avg-input.xlsx');

data= table2array(accelerations);
impulse= table2array(impulse_data);
time_avg= table2array(time_avg_data);

axisX = data(:, 1);
axisY = data(:, 2);
axisZ = data(:, 3);

input = time_avg(:, 3);
output = time_avg(:, 2);

fs = 100;

clf
winlen = size(input, 1);
modalfrf(input(:),output(:),fs,winlen,'Sensor','acc')

