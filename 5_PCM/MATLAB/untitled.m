clc;
clear;
close all;

%% 1. Basic Parameters
fs = 100e3;         % Sampling frequency (Hz)
t = 0:1/fs:5e-3;    % Time vector (5 milliseconds)
N = length(t);      % Number of samples

f_msg = 1000;       % Message signal frequency (Hz)
f_sample = 10e3;    % Sampling frequency for PCM (Hz)
quant_levels = 16;  % Number of quantization levels (4 bits)

%% 2. Generate Message Signal
msg = 0.5 * sin(2*pi*f_msg*t); % Message between -0.5 and 0.5 for PCM

%% 3. Generate Sampled Signal
sample_period = 1/f_sample;
sample_times = 0:sample_period:(length(t)/fs);
sample_indices = round(sample_times * fs) + 1;
sample_indices = sample_indices(sample_indices <= N);
msg_sampled = zeros(size(t));
msg_sampled(sample_indices) = msg(sample_indices);

%% 4. Generate Original PCM Signal
% Quantize the sampled signal
quant_edges = linspace(-0.5, 0.5, quant_levels+1);
quant_values = quant_edges(1:end-1) + (quant_edges(2) - quant_edges(1))/2;
pcm_original = zeros(size(t));
for i = 1:length(sample_indices)
    [~, idx] = min(abs(msg(sample_indices(i)) - quant_edges));
    pcm_original(sample_indices(i)) = quant_values(max(1, idx-1));
end
% Hold the quantized values between samples
for i = 1:length(sample_indices)-1
    idx = sample_indices(i):sample_indices(i+1)-1;
    pcm_original(idx) = pcm_original(sample_indices(i));
end
if sample_indices(end) < N
    pcm_original(sample_indices(end):end) = pcm_original(sample_indices(end));
end

%% 5. Add Noise Section and Analyze Effect
SNR_levels = [20, 10, 5, 0];  % Signal-to-Noise Ratio levels (dB)
error_rates = zeros(length(SNR_levels), 1);

figure('Name', 'PCM with Noise Analysis');
for i = 1:length(SNR_levels)
    SNR = SNR_levels(i);
    msg_noisy = awgn(msg, SNR, 'measured');
    msg_noisy = max(-0.5, min(0.5, msg_noisy)); % Clip to [-0.5, 0.5]
    
    pcm_noisy = zeros(size(t));
    for j = 1:length(sample_indices)
        [~, idx] = min(abs(msg_noisy(sample_indices(j)) - quant_edges));
        pcm_noisy(sample_indices(j)) = quant_values(max(1, idx-1));
    end
    for j = 1:length(sample_indices)-1
        idx = sample_indices(j):sample_indices(j+1)-1;
        pcm_noisy(idx) = pcm_noisy(sample_indices(j));
    end
    if sample_indices(end) < N
        pcm_noisy(sample_indices(end):end) = pcm_noisy(sample_indices(end));
    end
    
    error_rate = sum(pcm_noisy ~= pcm_original) / N;
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
    plot(t*1000, pcm_noisy, 'k', 'LineWidth', 1.5);
    title(['PCM Output (SNR = ', num2str(SNR), ' dB)']);
    xlabel('Time (ms)');
    ylabel('PCM');
    ylim([-0.7 0.7]);
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
plot(t*1000, msg_sampled, 'r', 'LineWidth', 1.5);
title('Sampled Signal');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t*1000, pcm_original, 'k', 'LineWidth', 1.5);
title('PCM Output Signal (No Noise)');
xlabel('Time (ms)');
ylabel('PCM');
ylim([-0.7 0.7]);
grid on;

%% 7. Display Error Rates
figure('Name', 'Error Rate vs SNR');
plot(SNR_levels, error_rates, 'bo-', 'LineWidth', 2);
xlabel('SNR (dB)');
ylabel('Error Rate');
title('PCM Error Rate vs SNR');
grid on;

disp('SNR (dB) | Error Rate');
disp('---------+------------');
for i = 1:length(SNR_levels)
    fprintf('%8d | %.6f\n', SNR_levels(i), error_rates(i));
end

%% 8. Save Figures as PNG
output_folder = fullfile(pwd, 'PCM_Outputs');
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

