clc;
clear;
close all;

%% 1. Basic Parameters
fs = 100e3;         % Sampling frequency (Hz)
t = 0:1/fs:5e-3;    % Time vector (5 milliseconds)
N = length(t);      % Number of samples

f_msg = 1000;       % Message signal frequency (Hz)
f_carrier = 10e3;   % Carrier frequency (Hz)

%% 2. Generate Message Signal
msg = 0.5 * sin(2*pi*f_msg*t);  % Message between -0.5 and 0.5

%% 3. Generate Carrier Signal
carrier = sawtooth(2*pi*f_carrier*t, 0.5);  % Triangular wave

%% 4. Generate Original PWM Signal
pwm_original = msg > carrier;

%% 5. Add Noise Section and Analyze Effect
SNR_levels = [20, 10, 5, 0];  % Signal-to-Noise Ratio levels (dB)
error_rates = zeros(length(SNR_levels), 1);

figure('Name', 'PWM with Noise Analysis');
for i = 1:length(SNR_levels)
    SNR = SNR_levels(i);
    msg_noisy = awgn(msg, SNR, 'measured');
    
    pwm_noisy = msg_noisy > carrier;
    
    error_rate = sum(pwm_noisy ~= pwm_original) / N;
    error_rates(i) = error_rate;
    
    subplot(length(SNR_levels), 2, 2*i-1);
    plot(t*1000, msg_noisy, 'b', 'LineWidth', 1.5);
    hold on;
    plot(t*1000, msg, 'g--', 'LineWidth', 1);
    title(['Noisy Message Signal (SNR = ', num2str(SNR), ' dB)']);
    xlabel('Time (ms)');
    ylabel('Amplitude');
    legend('Noisy Message', 'Original Message');
    grid on;
    
    subplot(length(SNR_levels), 2, 2*i);
    plot(t*1000, pwm_noisy, 'k', 'LineWidth', 1.5);
    title(['PWM Output (SNR = ', num2str(SNR), ' dB)']);
    xlabel('Time (ms)');
    ylabel('PWM');
    ylim([-0.2 1.2]);
    grid on;
end

%% 6. Plot Original Signals
figure('Name', 'Original Signals');
subplot(3,1,1);
plot(t*1000, msg, 'b', 'LineWidth', 1.5);
title('Message Signal');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t*1000, carrier, 'r', 'LineWidth', 1.5);
title('Carrier Signal');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t*1000, pwm_original, 'k', 'LineWidth', 1.5);
title('PWM Output Signal (No Noise)');
xlabel('Time (ms)');
ylabel('PWM');
ylim([-0.2 1.2]);
grid on;

%% 7. Display Error Rates
figure('Name', 'Error Rate vs SNR');
plot(SNR_levels, error_rates, 'bo-', 'LineWidth', 2);
xlabel('SNR (dB)');
ylabel('Error Rate');
title('PWM Error Rate vs SNR');
grid on;

disp('SNR (dB) | Error Rate');
disp('---------+------------');
for i = 1:length(SNR_levels)
    fprintf('%8d | %.6f\n', SNR_levels(i), error_rates(i));
end

%% 8. Save Figures as PNG
% Create output folder if it doesn't exist
output_folder = fullfile(pwd, 'PWM_Outputs');
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% Save each figure
fig_handles = findall(0, 'Type', 'figure');
for i = 1:length(fig_handles)
    fig = fig_handles(i);
    fig_name = get(fig, 'Name');
    % Replace invalid characters in filename
    fig_name = strrep(fig_name, ' ', '_');
    fig_name = strrep(fig_name, ':', '');
    saveas(fig, fullfile(output_folder, [fig_name '.png']));
end
