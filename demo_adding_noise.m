clear all; 

addpath(genpath(pwd));

clean_audio_filename = 'si955.wav';

noise_signal_filename = 'babble.wav';

[signal, fs] = audioread(clean_audio_filename);

disp ('playing the clean speech signal...');

soundsc(signal,fs);

[noise, sr] = audioread('babble.wav');

snr = 0;

noisy_signal = add_noise(signal,noise,snr);

filename_noisy_signal = [clean_audio_filename '_snr_' num2str(snr) '_' noise_signal_filename] ;

audiowrite(filename_noisy_signal, noisy_signal, 16000);


