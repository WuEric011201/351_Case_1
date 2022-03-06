% this function plots and returns the frequency response of a given
% frequency seperator
% 
% parameter: 
% idx: the index of frequency we wants to seperate out
% r: resistance of the filter
% c: capacitance of the filter
% order: times we pass the frequency
% freq: a list of frequencies be passed
% 
% returned value:
% freq: logspace(1,5,100)
% H: a 1*100 complex double array, with corresponding frequency produced
% by logspace(1,5,100);

function H = freqResponse(idx, r, c, order, freq)
    
    fs = 44.1e4; % sample frequency
    dt = 1/fs;
    tau = r*c; % time constant
    
    % coefficients for filter()
    aLow = [1, ((1/fs)/tau)-1]; bLow = (1/fs)/tau; % low-pass coeff
    aHigh = [1, ((1/fs)/tau)-1]; bHigh = [1, -1]; % high-pass coeff

    % define a range of freqency the bode plot wants to cover
    w = 2*pi.*freq;
    H = zeros(1,length(freq));

    for i = 1:length(freq)
        t = 0:dt:30/freq(i); % time interval
        freq_in = exp(1j*w(i).*t); % generate the input
        
        temp = freq_in;
        
        % calculate the frequency output
        for j = 1:order
            if (idx < 5)
                % pass the low-pass if index is 1 to 4
                temp = filter(bLow, aLow, temp);
            end
            if (idx > 1)
                % pass the low-pass if index is 2 to 5
                temp = filter(bHigh, aHigh, temp);
            end
        end
        
        % frequency output
        freq_out = temp;
        
        % calculate the gain from steady state
        steady_state = int32(length(t)*3/4):length(t);
        H(i) = mean(freq_out(steady_state)./freq_in(steady_state));
    end
    
    % magnitude and phase of the gain
    magnitude = abs(H);
    phase = (angle(H)./ pi);
    
    % plot the magnitude and phase
    figure('name', sprintf('Frequency Separation No.%d', idx));
    subplot(2,1,1);
    semilogx(freq, magnitude);
    title('magnitude v.s. frequency')
    xlabel('frequency (Hz)'); ylabel('magnitude');

    subplot(2,1,2)
    semilogx(freq, phase);
    title('phase (nomalized by /pi) v.s. frequency');
    xlabel('frequency (Hz)'); ylabel('phase');
    
end