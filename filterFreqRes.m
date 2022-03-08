% this function plots and returns the frequency response of a given
% frequency seperator
% 
% parameter: 
% aLow,  bLow: low pass filter a and b coefficient
% aHigh ,bHigh: high pass filter a and b coefficient
% order: times we pass the frequency
% type: l: means only passes through low;  (1 by n array)
%       h: means only passes through high
%       x: means passes through low and high
% freq: a list of frequencies be passed
% fs: the sample frequency
%  the number of frequency seperation
% 
% returned value:
% H: a result frequency response 


function H = filterFreqRes(  aLow,  bLow, aHigh ,bHigh , order, type, fs, freq, j)
    
    w = 2*pi.*freq; % frequencies in rad/s
    
    % initialize the output
    H = zeros(1,length(freq));

for f = 1:length(freq)
            
            t = 0 : 1/fs : 30/freq(f); % time interval
            freq_in = exp(1j*w(f).*t); % generate the input
            
            % frequency output
            freq_out = filter_with_order(freq_in, aLow, bLow, aHigh, bHigh, order, type);

            % calculate the gain from steady state
            steady_state = int32(length(t)*3/4):length(t);
            H(1, f) = mean(freq_out(steady_state)./freq_in(steady_state));  
end

        % magnitude and phase of the gain
        magnitude = abs(H);
        phase = (angle(H)./ pi);

        % plot the magnitude and phase
        figure;
        subplot(2,1,1);
        semilogx(freq, magnitude);
        title(['magnitude v.s. frequency' sprintf(' of frequency separation No.%d', j)]);
        xlabel('frequency (Hz)'); ylabel('magnitude');

        subplot(2,1,2)
        semilogx(freq, phase);
        title(['phase (nomalized by /pi) v.s. frequency' sprintf(' of frequency separation No.%d', j)]);
        xlabel('frequency (Hz)'); ylabel('phase');
    
end
