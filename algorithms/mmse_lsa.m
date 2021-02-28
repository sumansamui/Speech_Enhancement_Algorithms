%%  Copyright (c) 2015 by Suman Samui

function mmse_lsa(noisyFile,enhancedFile)


[y, sr] = audioread(noisyFile);

%% STFT parameters

frLen   = 32e-3*sr;  % frame size
fShift  = frLen/2;   % fShift size
nFrames = floor(length(y)/fShift)-1; % number of frames
anWin  = hanning(frLen,'periodic'); %analysis window
NFFT = 512;


%PERC=50; % window overlap in percent of frame size
len1=floor(fShift);
len2=frLen-len1;
%% Noise power calculation calculations - assuming that the first 6 frames is
% noise/silence 

noise_mean=zeros(NFFT,1);
j=1;
for m=1:6
    noise_mean=noise_mean+abs(fft(anWin.*y(j:j+frLen-1),NFFT));
    j=j+frLen;
end
noise_mu=noise_mean/6;
noise_mu2=noise_mu.^2;

%% Processing
%--- allocate memory and initialize various variables
k = 1;
x_old=zeros(len1,1);
alpha = 0.9;
zeta_min=10^(-25/10);
eta=0.15; 
mu=0.98;

%===============================  Start Processing =======================================================


for n=1:nFrames


    seg = anWin.*y(k:k+frLen-1);

    %--- Take fourier transform of  frame

    spec=fft(seg,NFFT);
    spec_ph = angle(spec);
    sig=abs(spec); % compute the magnitude
    sig2=sig.^2;
    
    
    gammak = min(sig2./noise_mu2,40);  % posteriori SNR
    

    if n==1
        zeta = alpha + (1-alpha)*max(gammak-1,0);
    else
        zeta = alpha*Yk_prev./noise_mu2 + (1-alpha)*max(gammak-1,0);     % a priori SNR
        zeta = max(zeta_min,zeta);  % limit zeta to -25 dB
    end
    
    
    log_sigma_k = gammak.* zeta./ (1+ zeta)- log(1+ zeta);    
    vad_decision= sum(log_sigma_k)/frLen;    
    if (vad_decision< eta) 
        % noise only frame found
        noise_mu2= mu* noise_mu2+ (1- mu)* sig2;
    end
    % ===end of vad===
    
    A = zeta./(1+zeta);
        
    nu = A.*gammak ;
    
    B = 0.5*expint(nu);
    
    hw = A.*exp(B);
        
    %hw = 1;

    sig=sig.*hw;
    Yk_prev=sig.^2;

    xi_w = ifft(hw.*spec, NFFT);
    xi_w = real(xi_w);


    % --- Overlap and add ---------------
    %
    xfinal(k:k+ len2-1)= x_old + xi_w(1:len1);
    x_old= xi_w(len1+ 1: frLen);

    k=k+len2;
end
%========================================================================================


audiowrite(enhancedFile,xfinal,sr);