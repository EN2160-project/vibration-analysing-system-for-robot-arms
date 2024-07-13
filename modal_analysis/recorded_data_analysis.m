datatable = readtable('data1.csv');
% Convert the table to an array
data= table2array(datatable);

axisX = data(:, 1);
axisY = data(:, 2);
axisZ = data(:, 3);

% Calculate the resultant magnitude
output = sqrt(axisX.^2 + axisY.^2 + axisZ.^2);
output = axisZ;

fs = 1000;
dt  = 1/ fs;
T = 4895*dt;

% Time array
t = 0:dt:T;
% Make it one element shorter
T = T - dt;
t = 0:dt:T;

% Input array
% Generate the impulse input
input = zeros(size(t));
input(2096:2102) = 1.2;


% Plot both the input and the output on the same graph
figure;
subplot(2, 1, 1);
plot(t, input);
title('Input Impulse Function');
xlabel('Time');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, output);
title('Impulse Response of the System');
xlabel('Time');
ylabel('Output');

clf
winlen = size(input, 2);
modalfrf(input(:),output(:),fs,winlen)