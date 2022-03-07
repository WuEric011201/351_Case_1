%% Task 1 - process "Giant Steps" by John Coltrane and "Space Station" by Art Farmer

% Process"Giant Steps"

% Set up the parameters
c_gsl = [5e-6, 5e-6, 3e-6, 2e-6, 7.5e-7];    
r_gsl = [50, 65, 50, 30, 60];
order = [11, 11, 11, 11, 11];
magnitude  = [20, 1000, 800, 800, 4];
type = ['l', 'x', 'x' , 'x', 'h'];
% 1/RC = 4000, 3077, 6667, 16667, 22222
[output1_gs, new_fs_gs] = freqSep("Giant Steps Bass Cut.wav", r_gsl, c_gsl, r_gsl, c_gsl, order, magnitude, type); 


% Process "Space Station"

% Set up the parameters
c_ss = [5e-6, 5e-6, 3e-6, 2e-6, 7.5e-7];    
r_ss = [50, 65, 50, 30, 60];
order = [11, 11, 11, 11, 11];
magnitude  = [0.9, 700, 800, 800, 10];
type =  ['l', 'x', 'x' , 'x', 'h'];
% 1/RC = 4000, 3077, 6667, 16667, 22222
[output1_ss, new_fs_ss] = freqSep("Space Station - Treble Cut.wav", r_ss, c_ss, r_ss, c_ss, order, magnitude,  type); 

sound(output1_gs, new_fs_gs);
    pause(5);
        clear sound;
sound(output1_ss, new_fs_ss);
    pause(5);
        clear sound;



  %% Task 2 Clear the siren in “Blue in Green” by Miles Davis
% Set up the parameters
%  high cut / low pass at 2.2 kHz for filtering second and later harmonics of the
%  siren 

c_bgl = [7.58E-6];    
r_bgl = [60];
order = [11];
magnitude  = [2];
type = ['l'];
[output_bg, new_fs_bg] = freqSep('Blue in Green with Siren.wav', r_bgl, c_bgl, r_bgl, c_bgl, order, magnitude, type); 

audiowrite('filtered_higher_BG.wav', output_bg, new_fs_bg);

% lowpass cutoff at 0.75  and highpass cutoff at 1.64  kHz for filtering the first harmonics of the siren
c_bgl =  [2.22E-5, 1.016E-5];    
r_bgl= [60, 60];
c_bgh = [2.22E-5, 1.016E-5];    
r_bgh= [60, 60];
order = [11, 11];
magnitude  = [2, 2];
type = ['l', 'h'];
[output1_bg, new_fs_bg] = freqSep('filtered_higher_BG.wav', r_bgl, c_bgl, r_bgh, c_bgh, order, magnitude, type); 

sound(output1_bg, new_fs_bg);
    pause(5);
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
