%%
%part_a_FM
f_1 = 30;
f_2 = 60;
fs = 1000; %// sample rate
dt = 1/fs;
fc = 200; %// carrier
t = 0:dt:1000;
m = cos(2*pi*f_1*t) +cos(2*pi*f_2*t);
mudulated = fmmod(m,fc,fs,50);
noise_add = awgn(mudulated,20,'measured');
demulated = fmdemod(noise_add,fc,fs,50);
figure;
subplot(4,1,1)
plot(t,m)
xlim([0,0.1])
grid on; grid minor;
title("input signal");
xlabel('t');ylabel('m(t)');
subplot(4,1,2)
plot(t,mudulated,'k')
xlim([0,0.5])
grid on; grid minor;
title("fm moudulated input signal");
xlabel('t');ylabel('fm_m(t)');
subplot(4,1,3)
plot(t,noise_add,'c')
xlim([0,0.5])
grid on; grid minor;
title("fm moudulated input signal");
xlabel('t');ylabel('fm_m(t)');
subplot(4,1,4)
plot(t,demulated,'r--*')
hold on;
plot(t,m,'g')
xlim([0,0.1])
grid on; grid minor;
title("fm demodulated signal after adding gussian noise");
legend('demolated signal','ínput signal')
rate = immse(demulated,m)
%%
%part_a_PM
f_1 = 30;
f_2 = 60;
fs = 1000; %// sample rate
dt = 1/fs;
fc = 200; %// carrier
t = 0:dt:1000;
m = cos(2*pi*f_1*t) +cos(2*pi*f_2*t);
mudulated = pmmod(m,fc,fs,pi/4);
noise_add = awgn(mudulated,20,'measured');
demulated = pmdemod(noise_add,fc,fs,pi/4);
figure;
subplot(4,1,1)
plot(t,m)
xlim([0,0.1])
grid on; grid minor;
title("input signal");
xlabel('t');ylabel('m(t)');
subplot(4,1,2)
plot(t,mudulated,'k')
xlim([0,0.5])
grid on; grid minor;
title("fm moudulated input signal");
xlabel('t');ylabel('fm_m(t)');
subplot(4,1,3)
plot(t,noise_add,'c')
xlim([0,0.5])
grid on; grid minor;
title("pm moudulated input signal");
xlabel('t');ylabel('pm_m(t)');
subplot(4,1,4)
plot(t,demulated,'r--*')
hold on;
plot(t,m,'g')
xlim([0,0.1])
grid on; grid minor;
title("pm demodulated signal after adding gussian noise");
legend('demolated signal','ínput signal')
rate = immse(demulated,m)
%%
%part_b_signal_fft&time domine
[y,Fs] = audioread('sound.wav');
t = linspace(0,length(y)/Fs,length(y));
figure;
plot(t,y);
title('voice file time domine');
grid on ; grid minor;xlabel('t(s)');ylabel('X(t)');
%%
%part_b
num = length(y);
F = -Fs/2 : Fs/num : Fs/2 - Fs/num;
fft_voice = fftshift(fft(y));
figure;
plot(F,abs(fft_voice)/Fs)
title('frequency spectrum of voice file');
grid on ; grid minor;xlabel('F');ylabel('X(e^(jw)))');
%%
%fm
mudulated = fmmod(y,fc,fs,50);
noise_add = awgn(mudulated,20,'measured');
demulated = fmdemod(noise_add,fc,fs,50);
noise_addedfile = audioplayer(demulated,Fs);
play(noise_addedfile)
filename = 'fm_noise_add.wav';
%audiowrite(filename,demulated,Fs)

rate_fm_sound = immse(demulated,y)
%%
%pm
mudulated = pmmod(y,fc,fs,pi/4);
noise_add = awgn(mudulated,20,'measured');
demulated = pmdemod(noise_add,fc,fs,pi/4);
noise_addedfile = audioplayer(demulated,Fs);
filename = 'pm_noise_add.wav';
%audiowrite(filename,demulated,Fs)
play(noise_addedfile)
rate_pm_sound = immse(demulated,y)

























