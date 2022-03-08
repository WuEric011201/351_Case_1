% this function plots and returns impulse response of the filters in a
% given frequency seperator
% 
% function used: lsim_with_order()
% 
% parameter: 
% rl, rh: resistance of the filter (high and low)
% cl, ch: capacitance of the filter (high and low)
% order: times we pass the frequency
% type: l: means only passes through low;  (1 by n array)
%       h: means only passes through high
%       x: means passes through low and high
% t: time vector of the impulse
%
% return value:
% output: a m*n matrix of impulse responses
%       m: the number of filters in the frequency seperator
%       n: the length of the time vector

function output = filterImpulseRes(rl, cl, rh, ch, order, type, t)
    
    % initialize the impulse and the impulse response
    input = [1 zeros(1, length(t)-1)];
    output = zeros(length(rl), length(t));
    
    % pass the filter
    for i = 1: length(rl)
        
        taul = rl(i)*cl(i); % time constant
        tauh = rh(i)*ch(i);

        % coefficients for lsim()
        aLow = [1, 1/tauh]; bLow = 1/tauh; % low-pass coeff
        aHigh = [1, 1/taul]; bHigh = [1 0]; % high-pass coeff
                
        % pass the filter for given times
        output(i,:) = lsim_with_order(input, aLow, bLow, aHigh, bHigh, order(i), type(i), t);
        
        % plot the response
        figure;
        plot(t, input, t, output(i,:));
        title(sprintf('impulse response of filter %d', i));
        xlabel('t'); ylabel('amplitude');
        legend('impulse', 'impulse response');
        
    end
end