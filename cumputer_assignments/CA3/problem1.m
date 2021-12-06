clc;
clear;
close all;
fs = 44.1e3; %// sample rate
dt = 1/fs;
fc = 200; %// carrier
df = 50; %// modulation excursion (Hz)
fm = 4; %// modulation rate (Hz)
tAx = dt:dt:1; %// time axis in seconds
u = sin(2*pi*fc*tAx + (df/fm)*cos(2*pi*fm*tAx));
figure;
plot(tAx,u);
grid on; grid minor;
title('fm modulated signal tiome domin');
hilbert_u = hilbert(u);
phase_hilbert_u = unwrap(angle(hilbert_u));
diff_phase_hilbert_u = diff(phase_hilbert_u);
figure;
subplot(2,1,1)
plot(tAx(2:length(tAx)),diff_phase_hilbert_u)
grid on; grid minor;
title('diff hilbert transform phase of signal in time domin');
subplot(2,1,2)
u = cos(2*pi*fm*tAx);
plot(tAx,u)
grid on; grid minor;
title('input in time domin');