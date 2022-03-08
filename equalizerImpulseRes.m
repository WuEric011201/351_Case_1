% this function plots and returns the impulse response of the whole
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
% t: time vector of the impulse
% 
% returned value:
% H: a complex double array, H(i) is the complex response of the impulse

function output = equalizerImpulseRes(rl, cl, rh, ch, order, magnitude, type, t)
    
    % initialize the impulse and the impulse response
    input = [1 zeros(1, length(t)-1)];
    output = zeros(1, length(t));
    
    % pass the filter
    for i = 1: length(rl)
        
        taul = rl(i)*cl(i); % time constant
        tauh = rh(i)*ch(i);

        % coefficients for filter()
        aLow = [1, 1/taul]; bLow = [1 0]; % low-pass coeff
        aHigh = [1 1/tauh]; bHigh = 1/tauh; % high-pass coeff
                
        % pass the filter for given times
        temp = lsim_with_order(input, aLow, bLow, aHigh, bHigh, order(i), type(i), t);
        % weight the output
        output = output+temp*magnitude(i);
        
    end
    
    % plot the response
    figure;
    plot(t, input, t, output);
    title('impulse response of the equalizer system');
    xlabel('t'); ylabel('amplitude');
    legend('impulse', 'impulse response');
    
end