
clear all;
addpath(genpath(pwd));

filename ='si834.wav';


param.FL = 20; % Frame-length in ms
param.FS = 10; % Frame-shift in ms
param.nFFT = 512;


spectrum =stft(filename, param);