%Bai tap da phuong tien
%Sinh vi�n: Nguyen Trong Tai
%MSSV: 20153267
%Lop: Dien tu 5 - K60
%ghi am
r= audiorecorder(44100,16,1);
disp('bat dau ghi am');
recordblocking(r,6);
disp('ket thuc');
r1 = getaudiodata(r,'int16');
audiowrite('orig_input.wav',r1,44100);
y= audioread('orig_input.wav');
%tao melody
fs = 44100; 
t = 1/fs : 1/fs : 1.5; 
f1 = 410; 
f2 = 2 * f1;
f3 = 3 * f1;
f4 = 4 * f1;
A1 = .3; A2 = A1/2; A3 = A1/3; A4 = A1/4;
y = y';
y1 = A1 * sin( 2 * pi * f1 * t  );
y2 = A2 * sin( 2 * pi * f2 * t  );
y3 = A3 * sin( 2 * pi * f3 * t  );
y4 = A4 * sin( 2 * pi * f4 * t  );
y5 = [y1 y2 y3 y4];
y6 = y5 + y;
audiowrite('melody.wav',y6,fs);


% bien doi fft
[y,fs] = audioread('melody.wav');
Y = fft(y);
plot(abs(Y));
figure(1)
N = length(y6); % number of FFT points
transform = fft(y6,N)/N;
magTransform = abs(transform);
figure
faxis = linspace(-N/2,N/2,N);
figure(2);
plot(faxis,fftshift(magTransform));
title('FFT');
xlabel('Frequency (Hz)');


%ve pho
figure(3);
win = 128; % window length in samples
% number of samples between overlapping windows:
hop = win/2;            

nfft = win; % width of each frequency bin 
spectrogram(y6,win,hop,nfft,fs,'yaxis');
yt = get(gca,'YTick');  
set(gca,'YTickLabel', sprintf('%.0f|',yt));
title('Spectrogram');