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
plot(1000*t,X)
title("Time domain Vibration Signal (Corrupted with Sensor noise)",'FontSize', 22)
xlabel("t (milliseconds)")
ylabel("X(t)")
xlim([1, length(X)]);

% Calculate STFT
[p,f,t] = pspectrum(X,fs,'spectrogram');

waterfall(f,t,p')
xlabel('Frequency (Hz)')
ylabel('Time (seconds)')
title("Spectrogram of the Vibration Signal",'FontSize', 22)
wtf = gca;
wtf.XDir = 'reverse';
view([30 45])