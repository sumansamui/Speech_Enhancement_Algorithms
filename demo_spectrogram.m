clear all;
addpath(genpath(pwd));

[s, fs] = audioread('si834.wav');

[n, sr] = audioread('white.wav');

n = n(1:length(s));

cmap = 'jet';

subplot(2,1,1)
plot_spectrogram(s, fs, [22 1], @hamming, 2048, [-59 -1], false, cmap, false, 'per')
title('Clean utterance', 'FontSize', 18);colorbar;


subplot(2,1,2)
plot_spectrogram(n, sr, [22 1], @hamming, 2048, [-59 -1], false, cmap, false, 'per')
title('Noise', 'FontSize', 18);colorbar;
