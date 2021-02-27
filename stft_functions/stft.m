function [spec] = stft(filename, params)

 % Copyright (c) 2015 by Suman Samui

[samples, fs] = audioread(filename);
Tw = params.FL; % Frame-length in msec 
Ts = params.FS; %Frame-shift (Hop) in msec
NFFT = params.nFFT;
WinL=(0.001*Tw)*fs; % Window-size/Frame-length in samples
FrameShift =(0.001*Ts)*fs; % Frame-shift/Hop size in samples 
frames = enframe(samples, hamming(WinL), FrameShift); % Generate Signal-frames
NF = size(frames,1); % Number of frames/segments after framing

%% STFT analysis

spec = fft(frames', NFFT); % Compute STFT spectrum
spec = spec(1:NFFT/2 + 1,:); % Retain the first half of the spectrum