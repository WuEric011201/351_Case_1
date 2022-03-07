%% Task 1 - process "Giant Steps" by John Coltrane and "Space Station" by Art Farmer

% Process"Giant Steps"

% Set up the parameters
c_gs = [5e-6, 5e-6, 3e-6, 2e-6, 7.5e-7];    
r_gs = [50, 65, 50, 30, 60];
order = [11, 11, 11, 11, 11];
magnitude  = [20, 800, 800, 800, 5];
type = ['l', 'x', 'x' , 'x', 'h'];
% 1/RC = 4000, 3077, 6667, 16667, 22222
[output1_gs, new_fs_gs] = freqSep("Giant Steps Bass Cut.wav", r_gs, c_gs, order, magnitude, type); 


% Process "Space Station"

% Set up the parameters
c = [5e-6, 5e-6, 3e-6, 2e-6, 7.5e-7];    
r = [50, 65, 50, 30, 60];
order = [11, 11, 11, 11, 11];
magnitude  = [1, 800, 800, 800, 30];
type =  ['l', 'x', 'x' , 'x', 'h'];
% 1/RC = 4000, 3077, 6667, 16667, 22222
[output1_ss, new_fs_ss] = freqSep("Space Station - Treble Cut.wav", r, c, order, magnitude,  type); 

sound(output1_gs, new_fs_gs);
    pause(6);
        clear sound;
sound(output1_ss, new_fs_ss);
    pause(6);
        clear sound;


%% First Frequency Magnitude Graph

R = 50; % the resistance
C = 5e-6; % the capacitan1ce
tau = R*C;
f = 44100;

range = logspace (0.1,4,100); % define a range of frequencies
w_range = 2.*pi.*range; % define a range of angular frequencies

time = 0:1/f:50*3*tau; % define the time vector
for t = 1:100 
    input11 = exp(1i.*w_range(t).*time); % output vector
    output1_gs = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input11);
    for n = 1:5
        output1_gs = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output1_gs));
    end
    H(t) = output1_gs(end)./input11(end);  % at the steady state
end

magnitude = abs(H);
phase = (angle(H)./ pi);

figure('name','First Frequency Separation')
subplot(2,1,1)
semilogx(range, magnitude)
title('magnitude v.s. frequency')
xlabel('frequency (Hz)')
ylabel('magnitude')

subplot(2,1,2)
semilogx(range, phase)
title('phase v.s. frequency')
xlabel('frequency (Hz)')
ylabel('phase')

%% Second Frequency Magnitude Graph

R = 65; % the resistance
C = 5e-6; % the capacitance
tau = R*C;
f = 44100;

range = logspace (0.1,4,100); % define a range of frequencies for calculation
w_range = 2.*pi.*range; % define a range of angular frequencies

time = 0:1/f:50*tau; % define the time vector
for t = 1:100
    input11 = exp(i.*w_range(t).*time); % output vector
    output1_gs = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input11);
    for n = 1:10
        output1_gs = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output1_gs));
        output1_gs = filter([1,-1],[1,(((1/f)/tau)-1)],output1_gs);
    end
    H(t) = output1_gs(end)./input11(end);  % at the steady state
end

magnitude = (abs(H));
phase = (angle(H)./ pi);

figure('name','Second Frequency Separation')
subplot(2,1,1)
semilogx(range, magnitude)
title('magnitude v.s. frequency')
xlabel('frequency (Hz)')
ylabel('magnitude')

subplot(2,1,2)
semilogx(range, phase)
title('phase v.s. frequency')
xlabel('frequency (Hz)')
ylabel('phase')
%% Third frequency Magnitude graph

R = 50; % the resistance
C = 3e-6; % the capacitance
tau = R*C;
f = 44100;

range = logspace (0.1,4,100); % define a range of frequencies
w_range = 2.*pi.*range; % define a range of angular frequencies

time = 0:1/f:50*tau; % define the time vector
for t = 1:100
    input11 = exp(1i.*w_range(t).*time); % output vector
    output1_gs = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input11);
    for n = 1:10
        output1_gs = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output1_gs));
        output1_gs = filter([1,-1],[1,(((1/f)/tau)-1)],output1_gs);
    end
    H(t) = output1_gs(end)./input11(end);  % at the steady state
end

magnitude = abs(H);
phase = (angle(H)./ pi);

figure('name','Third Frequency Separation')
subplot(2,1,1)
semilogx(range, magnitude)
title('magnitude v.s. frequency')
xlabel('frequency (Hz)')
ylabel('magnitude')

subplot(2,1,2)
semilogx(range, phase)
title('phase v.s. frequency')
xlabel('frequency (Hz)')
ylabel('phase')

%% Fourth Frequency Magnitude Graph

R = 30; % the resistance
C = 2e-6; % the capacitance
tau = R*C;
f = 441000;

range = logspace (0.1,5,100); % define a range of frequencies
w_range = 2.*pi.*range; % define a range of angular frequencies

time = 0:1/f:50*tau; % define the time vector
for t = 1:100
    input11 = exp(i.*w_range(t).*time); % output vector
    output1_gs = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input11);
    for n = 1:10
        output1_gs = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output1_gs));
        output1_gs = filter([1,-1],[1,(((1/f)/tau)-1)],output1_gs);
    end
    H(t) = output1_gs(end)./input11(end);  % at the steady state
end

magnitude = (abs(H));
phase = (angle(H)./ pi);

figure('name','Fourth Frequency Separation')
subplot(2,1,1)
semilogx(range, magnitude)
title('magnitude v.s. frequency')
xlabel('frequency (Hz)')
ylabel('magnitude')

subplot(2,1,2)
semilogx(range, phase)
title('phase v.s. frequency')
xlabel('frequency (Hz)')
ylabel('phase')


%% Fifth Frequency Magnitude Graph

% Let the cut-off frequency of low pass filter to be 120 Hz
R = 60; % the resistance
C = 7.5e-7; % the capacitance
tau = R*C;
f = 441000;

range = logspace (1,5,100); % define a range of frequencies for calculation
w_range = 2.*pi.*range; % define a range of angular frequencies

time = 0:1/f:50*tau; % define the time vector
for t = 1:10
    input11 = exp(i.*w_range(t).*time); % output vector
    output1_gs = filter([1,-1],[1,(((1/f)/tau)-1)],input11);
    for n = 1:10
        output1_gs = filter([1,-1],[1,(((1/f)/tau)-1)],output1_gs);
    end
    H(t) = output1_gs(end)./input11(end);  % at the steady state
end

magnitude = abs(H);
phase = (angle(H)./ pi);

figure('name','Fifth Frequency Separation')
subplot(2,1,1)
semilogx(range, magnitude)
title('magnitude v.s. frequency')
xlabel('frequency (Hz)')
ylabel('magnitude')

subplot(2,1,2)
semilogx(range, phase)
title('phase v.s. frequency')
xlabel('frequency (Hz)')
ylabel('phase')
