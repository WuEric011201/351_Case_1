% this function preprocess the sound wave by first remove the sound that
% are below the threshhold and then increase the sampling frequency of the
% sound
% 
% parameters:
% input: a input array of the original sound 
% threshhold: the magnitude of the sound: the signal below the magnitude
% will be removed
% old_fs: old sampling frequency
% new_fs: new sampling frequency
% 
% returned value:
% output: a processed sound



function output = prepocess(input, threshold, old_fs, new_fs)
    % remove sound too quiet in the beginning 
idx = find(any(abs(input) > threshold, 2), 1);
input(1:idx-1,:) = [];
    
    [P,Q] = rat(new_fs/old_fs);
    input = resample(input,P,Q);
    
    output = input; 
end