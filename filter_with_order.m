% This function does the actual filtering
% parameter: 
% signal: signal we want to filter
% aLow, bLow, aHigh, bHigh: parameters of filter
% order: number of times the filter in series
% type: type of filter
% returned value: filtered signal 


function signal = filter_with_order(signal, aLow, bLow, aHigh, bHigh, order, type)

        % filter the input order of times
        for i = 1: order
    
            if (strcmp(type, 'l') ==1 )
                    % pass the low-pass 
                    signal = filter(bLow, aLow, signal);
                continue; 
            end
    
            % pass the high pass
            signal = filter(bHigh, aHigh, signal);
    
            if (strcmp(type, 'x') == 1)
                % pass the low-pass 
                signal = filter(bLow, aLow,  signal);
            end
        end

end
