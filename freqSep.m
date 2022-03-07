% this function seperates the operating freqency we want (from 1 to 5)
% 
% parameters:
% input: a string representing the name of the sound file 
% order: the number of times the RC circuits are in series (1 by n array)
% r, c are 1 by n array of R and C values; n is the number of filters
% magnitude: the number of times the filtered results will be amplified (1 by n array)
% fs: sample frequency for filter
% type: l: means only passes through low;  (1 by n array)
%  h: means only passes through high
%  x: means passes through low and high
% 
% returned value:
% output: filtered ouput with given frequency

function [output,new_fs]  = freqSep(input, r, c, order, magnitude, type)

[input_audio, input_Fs] = audioread(input);

%  sampling frequency (last parameter) -------  can change here. The higher
%  the better, but has a limit  --------- ???? find the optimal ?????
new_fs = 150000; 
input_audio = prepocess(input_audio, 0.0005, input_Fs, new_fs);    % a function writtten to preprocess the sound

% initialize the return matrix
output = zeros(size(input_audio, 1), size(input_audio, 2)); 

% Check size
if size(r, 2) ~= size(c, 2)
    error("dimension of r and c wrong");
end

% filter the audio size of r times
    for j = 1: size(r, 2)
        tau = r(1, j)* c(1, j); % time constant
        temp = input_audio; 
        % coefficients for filter()
        aLow = [1, ((1/new_fs)/tau)-1]; bLow = (1/new_fs)/tau; % low-pass coeff  %??
        aHigh = [1, ((1/new_fs)/tau)-1]; bHigh = [1, -1]; % high-pass coeff
        
        % filter the input order of times
        for i = 1: order(j)
    
            if (strcmp(type(j), 'l') ==1 )
                    % pass the low-pass 
                    temp = filter(bLow, aLow, temp);
                continue; 
            end
    
            % pass the high pass
            temp = filter(bHigh, aHigh, temp);
    
            if (strcmp(type(j), 'x') == 1)
                % pass the low-pass 
                temp = filter(bLow, aLow,  temp);
            end
    
        end
        
        temp = magnitude(j) .* temp; % time the magnitude
        output = output + temp;  % sum the result of each filter 

        sound(temp, new_fs);
        pause(2);
        clear sound;

    end

end