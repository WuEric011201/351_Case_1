% This function does the actual filtering using lsim()
% 
% parameter: 
% signal: signal we want to filter
% aLow, bLow, aHigh, bHigh: parameters of filter
% order: number of the filters in series
% type: l: means only passes through low
%       h: means only passes through high
%       x: means passes through low and high
% t: the time vector of the impulse
% 
% returned value: filtered signal

function signal = lsim_with_order(signal, aLow, bLow, aHigh, bHigh, order, type, t)

        % filter the input order of times
        for i = 1: order
            
            % low pass
            if (strcmp(type, 'l') == 1)
                signal = lsim(bLow, aLow, signal, t);
            end
            
            % high pass
            if (strcmp(type, 'h') == 1)
                signal = lsim(bHigh, aHigh, signal, t);
            end
            
            % band pass
            if (strcmp(type, 'x') == 1)
                signal = lsim(bLow, aLow, signal, t);
                signal = lsim(bHigh, aHigh, signal, t);
            end
            
        end

end
