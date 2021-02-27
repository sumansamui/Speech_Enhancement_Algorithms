function x = add_noise(s,n, snr) 
% Add noise to signal at a prescribed SNR level.

% making the length of noise vector and speech (audio) signal vector same 
if length(n)>length(s)
    n = n(1:length(s));
else
    s = s(1:length(n));
end

% scale the noise file to get required SNR
se = norm(s,2).^2; % signal power 
ned = se/(10^(snr/10)); % desired noise based on given snr 
ne = norm(n,2).^2;  % actual noise power based on given noise
n = sqrt(ned/ne).*n; % scale noise samples to get required SNR
x = s + n;  % the noisy signal
