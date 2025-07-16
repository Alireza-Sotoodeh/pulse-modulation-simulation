clc;
clear;
close all;

%% 1. Basic Parameters
fs = 100e3;         % Sampling frequency (Hz)
t = 0:1/fs:5e-3;    % Time vector (5 milliseconds)
N = length(t);      % Number of samples

f_msg = 1000;       % Message signal frequency (Hz)
f_carrier = 10e3;   % Carrier frequency (Hz)
pulse_width = 1/(2*f_carrier); % Pulse width (half carrier period)

%% 2. Generate Message Signal
msg = 0.5 * sin(2*pi*f_msg*t) + 0.5; % Message between 0 and 1 for PPM

%% 3. Generate Carrier Signal
% Generate a pulse train as carrier
carrier_period = 1/f_carrier;
pulse_times = 0:carrier_period:(length(t)/fs);
carrier = zeros(size(t));
for i = 1:length(pulse_times)-1
    idx = (t >= pulse_times(i)) & (t < pulse_times(i) + pulse_width);
    carrier(idx) = 1;
end

%% 4. Generate Original PPM Signal
ppm_original = zeros(size(t));
for i = 1:length(pulse_times)-1
    % Calculate pulse position based on message amplitude
    msg_idx = find(t >= pulse_times(i), 1);
    if msg_idx <= length(msg)
        position_shift = msg(msg_idx) * (carrier_period - pulse_width);
        pulse_start = pulse_times(i) + position_shift;
        idx = (t >= pulse_start) & (t < pulse_start + pulse_width);
        ppm_original(idx) = 1;
    end
end

%% 5. Add Noise Section and Analyze Effect
SNR_levels = [20, 10, 5, 0];  % Signal-to-Noise Ratio levels (dB)
error_rates = zeros(length(SNR_levels), 1);

figure('Name', 'PPM with Noise Analysis');
for i = 1:length(SNR_levels)
    SNR = SNR_levels(i);
    msg_noisy = awgn(msg, SNR, 'measured');
    msg_noisy = max(0, min(1, msg_noisy)); % Clip to [0, 1] for valid PPM
    
    ppm_noisy = zeros(size(t));
    for j = 1:length(pulse_times)-1
        msg_idx = find(t >= pulse_times(j), 1);
        if msg_idx <= length(msg_noisy)
            position_shift = msg_noisy(msg_idx) * (carrier_period - pulse_width);
            pulse_start = pulse_times(j) + position_shift;
            idx = (t >= pulse_start) & (t < pulse_start + pulse_width);
            ppm_noisy(idx) = 1;
        end
    end
    
    error_rate = sum(ppm_noisy ~= ppm_original) / N;
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
    plot(t*1000, ppm_noisy, 'k', 'LineWidth', 1.5);
    title(['PPM Output (SNR = ', num2str(SNR), ' dB)']);
    xlabel('Time (ms)');
    ylabel('PPM');
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
plot(t*1000, ppm_original, 'k', 'LineWidth', 1.5);
title('PPM Output Signal (No Noise)');
xlabel('Time (ms)');
ylabel('PPM');
ylim([-0.2 1.2]);
grid on;

%% 7. Display Error Rates
figure('Name', 'Error Rate vs SNR');
plot(SNR_levels, error_rates, 'bo-', 'LineWidth', 2);
xlabel('SNR (dB)');
ylabel('Error Rate');
title('PPM Error Rate vs SNR');
grid on;

disp('SNR (dB) | Error Rate');
disp('---------+------------');
for i = 1:length(SNR_levels)
    fprintf('%8d | %.6f\n', SNR_levels(i), error_rates(i));
end

%% 8. Save Figures as PNG
output_folder = fullfile(pwd, 'PPM_Outputs');
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

fig_handles = findall(0, 'Type', 'figure');
for i = 1:length(fig_handles)
    fig = fig_handles(i);
    fig_name = get(fig, 'Name');
    fig_name = strrep(fig_name, ' ', '_');
    fig_name = strrep(fig_name, ':', '');
    saveas(fig, fullfile(output_folder, [fig_name '.png']));
end
