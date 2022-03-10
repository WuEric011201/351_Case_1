% this function plots and returns the frequency response of the whole
% equilizer system (5 filters with different weights)
% 
% parameter: 
% rl, rh: resistance of the filter (high and low)
% cl, ch: capacitance of the filter (high and low)
% order: times we pass the frequency
% magnitude: different weights of the filters in the system
% type: l: means only passes through low;  (1 by n array)
%       h: means only passes through high
%       x: means passes through low and high
% freq: a list of frequencies be passed
% fs: the sample frequency
% name: the name of the equalizer
% 
% returned value:
% H: a complex double array, H(i) is the complex response of frequency in
% freq(i)

function H = equalizerFreqRes(rl, cl, rh, ch, order, magnitude, type, fs, freq, name)
    
    w = 2*pi.*freq; % frequencies in rad/s
    
    % initialize the output and magnitude
    H = zeros(1,length(freq));
    mag = zeros(1,length(freq));
    
    % number of filters 
    for j = 1: length(rl)
        
        taul = rl(j)*cl(j); % time constant
        tauh = rh(j)*ch(j);

        % coefficients for filter()
        aLow = [1, ((1/fs)/taul)-1]; bLow = (1/fs)/taul; % low-pass coeff
        aHigh = [1, ((1/fs)/tauh)-1]; bHigh = [1, -1]; % high-pass coeff

        for f = 1:length(freq)
            
            t = 0 : 1/fs : 30/freq(f); % time interval
            freq_in = exp(1j*w(f).*t); % generate the input
            
            % frequency output
            freq_out = filter_with_order(freq_in, aLow, bLow, aHigh, bHigh, order(j), type(j));

            % calculate the region of steady state
            steady_state = int32(length(t)*3/4):length(t);
            % the actual gain of the steady state
            % the gain of certain frequency is the sum of gain*weight 
            avgGain = freq_out(steady_state)./freq_in(steady_state);
            H(f) = H(f) + mean(avgGain)*magnitude(j);
            mag(f) = mag(f) + mean(abs(avgGain))*magnitude(j);
            
        end
    
    end
    
    phase = angle(H)./pi;
    
    % plot the magnitude and phase
    figure;
    subplot(2,1,1);
    semilogx(freq, mag);
    title(sprintf(['magnitude v.s. frequency of the ' name]));
    xlabel('frequency (Hz)'); ylabel('magnitude');
    
    subplot(2,1,2);
    semilogx(freq, phase);
    title(sprintf(['phase (nomalized by /pi) v.s. frequency of the ' name]));
    xlabel('frequency (Hz)'); ylabel('phase');
    
end