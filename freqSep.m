% this function seperates the operating freqency we want (from 1 to 5)
% 
% parameters:
% input: a time domain function needs to be filtered
% order: the number of times the RC circuits are in series
% mag: the number of times the filtered results will be amplified
% fs: sample frequency for filter()
% type: low: means only passes through low; 
%  high: means only passes through high
%  lh: means passes through low and high
% 
% returned value:
% output: filtered ouput with given frequency

function output = freqSep(input, r, c, order, magnitude, fs, type)
    
    tau = r*c; % time constant
    
    % coefficients for filter()
    aLow = [1, ((1/fs)/tau)-1]; bLow = (1/fs)/tau; % low-pass coeff
    aHigh = [1, ((1/fs)/tau)-1]; bHigh = [1, -1]; % high-pass coeff
    
    % filter the input order of times
    for i = 1: order 

        if (strcmp(type, 'low') ==1 )
            % pass the low-pass 
            input = filter(bLow, aLow, input);
            continue; 
        end

        % pass the high pass
        input = filter(bHigh, aHigh, input);

        if (strcmp(type, 'lh') == 1)
            % pass the high-pass 
            input = filter(bHigh, aHigh, input);
        end

    end
    
    output = magnitude .* input;
    
end