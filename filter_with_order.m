% This function does the actual filtering
% parameter: 
% signal: signal we want to filter
% aLow, bLow, aHigh, bHigh: parameters of filter
% order: number of the filters in series
% type: type of filter (low, high, band)
% returned value: filtered signal


function signal = filter_with_order(signal, aLow, bLow, aHigh, bHigh, order, type)

        % filter the input order of times
        for i = 1: order
            
            % low pass
            if (strcmp(type, 'l') == 1)
                    signal = filter(bLow, aLow, signal);
            end
            
            % high pass
            if (strcmp(type, 'h') == 1)
                signal = filter(bHigh, aHigh, signal);
            end
            
            % band pass
            if (strcmp(type, 'x') == 1)
                signal = filter(bLow, aLow, signal);
                signal = filter(bHigh, aHigh, signal);
            end
            
        end

end
