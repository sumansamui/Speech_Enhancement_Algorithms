clear all; 

addpath(genpath(pwd));

filename_clean_signal = 'si955.wav';

filename_noise_signal = 'factory.wav';

[signal, fs] = audioread(filename_clean_signal);

[noise, sr] = audioread(filename_noise_signal);

snr = 0;

noisy_signal = add_noise(signal,noise,snr);

filename_noisy_signal = [filename_clean_signal '_snr_' num2str(snr) '_' filename_noise_signal] ;

audiowrite(filename_noisy_signal, noisy_signal, 16000);

filename_processed_signal = 'processed_mbss.wav';

%specsub(filename_noisy_signal,filename_processed_signal);

mbspecsub(filename_noisy_signal, filename_processed_signal, 6,'linear');

%mmse(filename_noisy_signal, filename_processed_signal);

%mmse_lsa(filename_noisy_signal, filename_processed_signal);

pesq_score = pesq(filename_clean_signal, filename_processed_signal);

stoi_score = stoi(filename_clean_signal, filename_processed_signal);

disp(sprintf('PESQ SCORE:%f',pesq_score));

disp(sprintf('STOI SCORE:%f',stoi_score));
