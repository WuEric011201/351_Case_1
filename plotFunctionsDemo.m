%% How fuctions work

% Set up the parameters
c = [5e-6, 5e-6, 3e-6, 2e-6, 7.5e-7];    
r = [50, 65, 50, 30, 60];
order1 = [11, 11, 11, 11, 11]; % for filter()
order2 = [1, 1, 1, 1, 1]; % for lsim() 
magnitude  = [5, 1000, 1000, 50, 3];
% low band band band high
type = ['l', 'x', 'x' , 'x', 'h'];

%% filterFreqRes(): output 5 frequency response plots

freq = logspace(1,5,100); % list of frequencies
% no need of magnitude
% output is 5*100 (5 filters, 100 frequencies)
freqRes = filterFreqRes(r, c, r, c, order1, type, freq);

%% filterImpulseRes(): output 5 impulse response plots

t = 0:1e-5:1e-3;
% no need of magnitude
% output is 5*length(t) (5 filters)
impulseRes = filterImpulseRes(r, c, r, c, order2, type, t);

%% equalizerFreqRes(): output 1 frequency response plot

freq = logspace(1,5,100); % list of frequencies
% need magnitude
% output is 1*100 (100 frequencies)
freqResE = equalizerFreqRes(r, c, r, c, order1, magnitude, type, freq);

%% equalizerImpulseRes(): output 1 impulse response plot

t = 0:1e-5:1e-3;
% no need of magnitude
% output is 5*length(t) (5 filters)
impulseResE = equalizerImpulseRes(r, c, r, c, order2, magnitude, type, t);
