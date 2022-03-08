% this function seperates the operating freqency we want (from 1 to 5) and
% weight the frequency sections with different magnitude
% 
% parameters:
% input: a string representing the name of the sound file 
% order: the number of times the RC circuits are in series (1 by n array)
% rl, cl are 1 by n array of R and C values; n is the number of low pass filters
% rh, ch are 1 by n array of R and C values; n is the number of high pass filters
% order: the times needed to pass the filter
% magnitude: the number of times the filtered results will be amplified (1 by n array)
% type: l: means only passes through low;  (1 by n array)
%       h: means only passes through high
%       x: means passes through low and high
% 
% returned value:
% output: filtered ouput with given frequency
% new_fs: the new sample frequency

function [output,new_fs]  = freqSep(input, rl, cl, rh, ch, order, magnitude, type)

    [input_audio, input_Fs] = audioread(input);

    %  sampling frequency (last parameter) -------  can change here. The higher
    %  the better, but has a limit  --------- ???? find the optimal ?????
    new_fs = 100000; 
    input_audio = prepocess(input_audio, 0.0005, input_Fs, new_fs); % a function written to preprocess the sound

    % initialize the return matrix
    output = zeros(size(input_audio, 1), size(input_audio, 2)); 

    freq = logspace(1,5, 60); 
%     Result of freq response
    H = zeros(size(rl, 2), length(freq)); 

    % j is the number of bands we have
    for j = 1: size(rl, 2)
        
        % time constant
        taul = rl(1, j)* cl(1, j); 
        tauh = rh(1, j)* ch(1, j);
        
        temp = input_audio; 
        
        % coefficients for filter()
        aLow = [1, ((1/new_fs)/taul)-1]; bLow = (1/new_fs)/taul; % low-pass coeff  %??
        aHigh = [1, ((1/new_fs)/tauh)-1]; bHigh = [1, -1]; % high-pass coeff
        
        % filter the temp signal using the method filter_with_order
        temp = filter_with_order(temp, aLow, bLow, aHigh, bHigh, order(j), type(j)); 
     
        temp = magnitude(j) .* temp; % time the magnitude
        output = output + temp;  % sum the result of each filter 

%         Plot individual band
        H(j , : ) = filterFreqRes(  aLow,  bLow, aHigh ,bHigh , order(j), type(j), new_fs, freq, j);
    end

% Plot the equalizer response all together
        equalizerFreqRes(rl, cl, rh, ch, order, magnitude, type, new_fs, logspace(1,5,60));
%         equalizerImpulseRes(rl, cl, rh, ch, order, magnitude, type, 0:1e-5:1e-3);
end