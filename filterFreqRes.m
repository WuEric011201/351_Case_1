% this function plots and returns the frequency response of a given
% frequency seperator
%
% functions used: lsim_with_order()
% 
% parameter: 
% rl, rh: resistance of the filter (high and low)
% cl, ch: capacitance of the filter (high and low)
% order: times we pass the frequency
% type: l: means only passes through low;  (1 by n array)
%       h: means only passes through high
%       x: means passes through low and high
% freq: a list of frequencies be passed
% fs: sampling freq
% 
% returned value:
% H: a m*n complex double matrix, with corresponding frequency produced
%       m: the number of filters
%       n: the length of the freq array

function H = filterFreqRes(rl, cl, rh, ch, order, type, freq, fs)
    
    w = 2*pi.*freq; % frequencies in rad/s
    
    % initialize the output
    H = zeros(length(rl),length(freq));
    
    for j = 1: length(rl)
        
        taul = rl(j)*cl(j); % time constant
        tauh = rh(j)*ch(j);
        
        % coefficients for lsim()
        aLow = [1, 1/tauh]; bLow = 1/tauh; % low-pass coeff
        aHigh = [1, 1/taul]; bHigh = [1 0]; % high-pass coeff

        for f = 1:length(freq)
            
            t = 0 : 1/fs : 30/freq(f); % time interval
            freq_in = exp(1j*w(f).*t)'; % generate the input
            
            % frequency output
            freq_out = lsim_with_order(freq_in, aLow, bLow, aHigh, bHigh, order(j), type(j), t);

            % calculate the gain from steady state
            steady_state = int32(length(t)*0.9):length(t);
            H(j, f) = mean(freq_out(steady_state)./freq_in(steady_state));
            
        end

        % magnitude and phase of the gain
        magnitude = abs(H(j, :));
        phase = (angle(H(j, :))./ pi);

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
end