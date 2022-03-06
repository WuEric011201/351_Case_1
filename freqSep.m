% this function seperates the operating freqency we want (from 1 to 5)
% 
% parameters:
% input: a time domain function needs to be filtered
% idx: the index of frequency we wants to seperate out
% fs: sample frequency for filter()
% 
% returned value:
% output: filtered ouput with given frequency

function output = freqSep(input, idx, fs)
    
    % capacitance and resistance used for different frequencies
    c = [5e-6, 5e-6, 3e-6, 2e-6, 7.5e-7];    
    r = [50, 65, 50, 30, 60];
    
    tau = r(idx)*c(idx); % time constant
    
    % coefficients for filter()
    aLow = [1, ((1/fs)/tau)-1]; bLow = (1/fs)/tau; % low-pass coeff
    aHigh = [1, ((1/fs)/tau)-1]; bHigh = [1, -1]; % high-pass coeff
    
    temp = input;
    
    % filter the input 10 times
    for i = 1:10
        if (idx < 5)
            % pass the low-pass if index is 1 to 4
            temp = filter(bLow, aLow, temp);
        end
        if (idx > 1)
            % pass the low-pass if index is 2 to 5
            temp = filter(bHigh, aHigh, temp);
        end
    end
    
    output = temp;
    
end