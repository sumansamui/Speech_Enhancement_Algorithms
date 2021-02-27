clear all; 

addpath(genpath(pwd));

clean_filename = 'si955.wav';

noisy_filename = 'si955.wav_snr_10_babble.wav'

pesq_score = pesq(clean_filename, noisy_filename);

stoi_score = stoi(clean_filename, noisy_filename);

disp(sprintf('PESQ SCORE:%f',pesq_score));

disp(sprintf('STOI SCORE:%f',stoi_score));