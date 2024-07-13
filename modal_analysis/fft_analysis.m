% Load csv data
datatable = readtable('data1.csv');
% Convert the table to an array
data= table2array(datatable);

% Get axis-wise vibration signal vectors
axisX = data(:, 1);
axisY = data(:, 2);
axisZ = data(:, 3);

% Select which axis
X = axisZ;

% Remove DC offset
X = X-mean(X);

% Sampling rates
fs = 1000;
T = 1/fs;
L = length(X);
t = (0:L-1)*T;

% Plot vibration signal
plot(1000*t,X) % Plot in milliseconds
title("Time domain Vibration Signal (Corrupted with sensor noise)",'FontSize', 22)
xlabel("t (milliseconds)")
ylabel("X(t)")
xlim([1, length(X)]);

% Wait for window to close
waitfor(gcf);

% Calculate FFT
Y = fft(X);

% Take single sided amplitude spectrum
% Scaling factor
P2 = abs(Y/L);
% Take the first half of the DFT
P1 = P2(1:L/2+1);
% Scaling by 2
P1(2:end-1) = 2*P1(2:end-1);

% Plot PSD using FFT
f = fs/L*(0:(L/2));
plot(f,P1,"LineWidth",1) 
title("Single-Sided Amplitude Spectrum of Vibration Signal", 'FontSize', 22)
xlabel("f (Hz)")
ylabel("|P(f)|")

% Wait for window to close
waitfor(gcf);

% Using Periodogram function
periodogram(X,rectwin(L),L,fs)