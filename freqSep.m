% this function seperates the operating freqency we want (from 1 to 5)
% 
% parameters:
% input: a string representing the name of the sound file 
% order: the number of times the RC circuits are in series (1 by n array)
% rl, cl are 1 by n array of R and C values; n is the number of low pass filters
% rh, ch are 1 by n array of R and C values; n is the number of high pass filters
% magnitude: the number of times the filtered results will be amplified (1 by n array)
% fs: sample frequency for filter
% type: l: means only passes through low;  (1 by n array)
%  h: means only passes through high
%  x: means passes through low and high
% 
% returned value:
% output: filtered ouput with given frequency

function [output,new_fs]  = freqSep(input, rl, cl, rh, ch, order, magnitude, type)

[input_audio, input_Fs] = audioread(input);

%  sampling frequency (last parameter) -------  can change here. The higher
%  the better, but has a limit  --------- ???? find the optimal ?????
new_fs = 150000; 
input_audio = prepocess(input_audio, 0.0005, input_Fs, new_fs);    % a function writtten to preprocess the sound

% initialize the return matrix
output = zeros(size(input_audio, 1), size(input_audio, 2)); 

% j is the number of bands we have
    for j = 1: size(rl, 2)
        taul = rl(1, j)* cl(1, j); % time constant
        tauh = rh(1, j)* ch(1, j);
        temp = input_audio; 
        % coefficients for filter()
        aLow = [1, ((1/new_fs)/taul)-1]; bLow = (1/new_fs)/taul; % low-pass coeff  %??
        aHigh = [1, ((1/new_fs)/tauh)-1]; bHigh = [1, -1]; % high-pass coeff
        
        temp = filter_with_order(temp, aLow, bLow, aHigh, bHigh, order(j), type(j)); 
     
        temp = magnitude(j) .* temp; % time the magnitude
        output = output + temp;  % sum the result of each filter 

        sound(temp, new_fs);
        pause(2);
        clear sound;

    end

end