% Load the music 
[input,frequency] = audioread('Blue in Green with Siren.wav'); 

input = (input(: , 1)+ input(: , 2))/2;  % combine into one channel 

% Draw the graph in time domain
time = 0:1/frequency:(length(input)-1)*(1/frequency); 
% this defines the time vector

figure("Name","Time Domain Reponse")
plot(time,input)
xlabel('t(seconds)')
ylabel('amplitude')

% Draw the graph in frequency domain
inputSnip = input(1:frequency); 
input_fft = fft(inputSnip);
frequency_vector = 0:frequency/length(inputSnip):(length(inputSnip)-1)*frequency/length(inputSnip);
%this defines the frequency coefficient over one period

figure("Name","Frequency Domain Reponse")
plot(frequency_vector,input_fft)
xlabel('f(Hz)')
ylabel('X(f)')

% Draw Power at each time and frequency
figure("Name","Power at each time and frequency")
spectrogram(input, 2048,200,2048, frequency)
