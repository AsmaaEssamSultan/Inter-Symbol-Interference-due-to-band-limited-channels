clc
close all
clear all
%Part1
%Inter-Symbol Interference due to band-limited channels
%% Simulation parameters
fs = 1e7;                       % Sampling rate (samples per sec)
Ts = 1/fs;                      % Sampling time
N = 1e5;                 % Total number of samples
t_axis = (0:N-1)*Ts;            % Time axis (the same during the entire experiment)
f_axis = -fs/2:fs/N:fs/2-1/N;   % Frequency axis (the same during the entire experiment)
Eb_No_db = 0;       % The specified Eb/No value in dB
Energy_per_bit = 1;             % The total energy of all samples constituting the square pulse
No = Energy_per_bit/(10.^(Eb_No_db/10));

%% Generate square pulses
%Paramerters
B = 100e3;
T_sq = 2/B;                     %The duration of the square pulse
x_bits = [1];
pulse1 = GenerateSquarePulses(t_axis,T_sq,Energy_per_bit,fs,x_bits,'unipolar'); 
x_bits = [0 1];
pulse2 = GenerateSquarePulses(t_axis,T_sq,Energy_per_bit,fs,x_bits,'unipolar');

pulse1_fft = GetFreqResponse(pulse1,fs);
pulse2_fft = GetFreqResponse(pulse2,fs);
%% Show time and frequency plots of the generated pulse
figure
subplot(3,1,1)
plot(t_axis,pulse1,'b','linewidth',2); hold on;
plot(t_axis,pulse2,'r','linewidth',2); hold on;
grid on
xlim([0 T_sq*4.2])
ylim([0 0.3])
xlabel('Time (s)','linewidth',2)
ylabel('Amplitude','linewidth',2)
legend('Pulse 1','Pulse 2','fontsize',10)

subplot(3,1,2)
plot(f_axis,abs(pulse1_fft),'b','linewidth',2); hold on;
plot(f_axis,abs(pulse2_fft),'r','linewidth',2); hold on;
grid on
ylim([0 30])
xlim([-1/T_sq 1/T_sq]*5)
xlabel('Frequency (Hz)','linewidth',2)
ylabel('Amplitude','linewidth',2)
legend('Pulse 1','Pulse 2','fontsize',10)
subplot(3,1,1)
title('Square pulses in time and frequency domains','linewidth',10)

%% Band-limited channel
one_square = ones(1,2000);
zero_me = zeros(1,98000/2);
Band_limited_channel= [zero_me one_square zero_me];

subplot(3,1,3)
plot(f_axis,Band_limited_channel,'linewidth',2)
grid on
ylim([0 2])
xlim([-1/T_sq 1/T_sq]*5)
xlabel('Frequency (Hz)','linewidth',2)
ylabel('Amplitude','linewidth',2)
subplot(3,1,3)
title('A Band-limited channel in frequency domains','linewidth',10)

%% %% 2 squre pulse pass through Band-limited channel
pulse1_after_chann = pulse1_fft .* Band_limited_channel;
pulse1_after_chann_T = ifft(ifftshift(pulse1_after_chann));
pulse2_after_chann = pulse2_fft .* Band_limited_channel;
pulse2_after_chann_T = ifft(ifftshift(pulse2_after_chann));

figure
subplot(2,1,1)
plot(t_axis,pulse1_after_chann_T,'b','linewidth',2); hold on;
plot(t_axis,pulse2_after_chann_T,'r','linewidth',2); hold on;
grid on
xlim([0 T_sq*5])
xlabel('Time (s)','linewidth',2)
ylabel('Amplitude','linewidth',2)
legend('Pulse 1','Pulse 2','fontsize',10)

subplot(2,1,2)
plot(f_axis,abs(pulse1_after_chann),'b','linewidth',2); hold on;
plot(f_axis,abs(pulse2_after_chann),'r','linewidth',2); hold on;
grid on
xlim([-1/T_sq 1/T_sq]*5)
ylim([0 50])
xlabel('Frequency (Hz)','linewidth',2)
ylabel('Amplitude','linewidth',2)
legend('Pulse 1','Pulse 2','fontsize',10)
subplot(2,1,1)
title('Square pulses after pass through channel','linewidth',10)

%% Sinc Function
t_axis = (-N/2:N/2-1)*Ts;
y = sinc(t_axis*B);
y1 = [zeros(1,100) y(1:99900)];
y2 = [zeros(1,200) y1(1:99800)];

y1_f = GetFreqResponse(y1,fs);
y2_f = GetFreqResponse(y2,fs);


figure
subplot(3,1,1)
plot(t_axis,y1,'b','linewidth',2); hold on;
plot(t_axis,y2,'r','linewidth',2); hold on;
xlim([0 0.00006])
grid on
xlabel('Time (s)','linewidth',2)
ylabel('Amplitude','linewidth',2)
legend('Sinc 1','Sinc 2','fontsize',10)
subplot(3,1,2)
plot(f_axis,abs(y1_f),'b','linewidth',2); hold on;;
plot(f_axis,abs(y2_f),'r','linewidth',2); hold on;;
xlim([-80000 80000])
grid on
xlabel('Frequency (Hz)','linewidth',2)
ylabel('Amplitude','linewidth',2)
legend('Sinc 1','Sinc 2','fontsize',10)
subplot(3,1,1)
title('Sinc function in time and frequency domains','linewidth',10)
subplot(3,1,3)
plot(f_axis,Band_limited_channel,'linewidth',2); hold on;
xlim([-110000 110000])
ylim([0 2])
grid on
xlabel('Frequency (Hz)','linewidth',2)
ylabel('Amplitude','linewidth',2)
subplot(3,1,3)
title('A Band-limited channel in frequency domains','linewidth',10)

y1_after_ch = y1_f .* Band_limited_channel;
y2_after_ch = y2_f .* Band_limited_channel;

y1_after_ch_T = ifft(ifftshift(y1_after_ch));
y2_after_ch_T = ifft(ifftshift(y2_after_ch));


figure
subplot(2,1,1)
plot(t_axis,y1_after_ch_T,'b','linewidth',2); hold on;
plot(t_axis,y2_after_ch_T,'r','linewidth',2); hold on;
xlim([0 0.00006])
grid on
xlabel('Time (s)','linewidth',2)
ylabel('Amplitude','linewidth',2)
legend('Sinc 1','Sinc 2','fontsize',10)
subplot(2,1,2)
plot(f_axis,abs(y1_after_ch),'b','linewidth',2); hold on;
plot(f_axis,abs(y2_after_ch),'r','linewidth',2); hold on;
xlim([-80000 80000])
grid on
xlabel('Frequency (Hz)','linewidth',2)
ylabel('Amplitude','linewidth',2)
legend('Sinc 1','Sinc 2','fontsize',10)
subplot(2,1,1)
title('Sinc function after pass through channel','linewidth',10)
