%% Frequency separation
% load the audio
load handel.mat; 

% First Frequency separation
R = 50; % the resistance
C = 5e-6; % the capacitance
tau = R*C; % 1/RC = 4000
f = Fs*20;  % Fs is the loaded frequency of music

input1 = y; % y is the loaded signal of music
output1 = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input1); % low pass
for n = 1:10 % ten RC in series 
    output1 = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output1));
end

% Second frequency separation
R = 65; % the resistance
C = 5e-6; % the capacitance
tau = R*C; % 1/RC = 3077

input2 = y;
output2 = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input2); %low pass
output2 = filter([1,-1],[1,(((1/f)/tau)-1)],output2); % high pass
for n = 1:10
    output2 = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output2));
    output2 = filter([1,-1],[1,(((1/f)/tau)-1)],output2);
end
output2 = output2.*1000; %adjust the magnitude

% Third frequency separation
R = 50; % the resistance
C = 3e-6; % the capacitance
tau = R*C; % 1/RC = 6667

input3 = y;
output3 = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input3); %low pass
output3 = filter([1,-1],[1,(((1/f)/tau)-1)],output3); % high pass
for n = 1:10
    output3 = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output3));
    output3 = filter([1,-1],[1,(((1/f)/tau)-1)],output3);
end
output3 = output3.*1000;


% Fourth frequency separation
R = 30; % the resistance
C = 2e-6; % the capacitance
tau = R*C; % 1/RC = 16667

input4 = y;
output4 = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input4); %low pass
output4 = filter([1,-1],[1,(((1/f)/tau)-1)],output4);
for n = 1:10
    output4 = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output4));
    output4 = filter([1,-1],[1,(((1/f)/tau)-1)],output4);
end
output4 = output4.*800;


% Fifth Frequency Separation
R = 60; % the resistance
C = 7.5e-7; % the capacitance
tau = R*C; %1/RC = 22222

input5 = y;
output5 = filter([1,-1],[1,(((1/f)/tau)-1)],input5);
for n = 1:10
    output5 = filter([1,-1],[1,(((1/f)/tau)-1)],output5);
end
output5 = output5.*800;

%% Test listening section
sound(output1, f);
    pause(5);
        clear sound;
sound(output2, f);
    pause(5);
        clear sound;
sound(output3, f);
    pause(5);
        clear sound;
sound(output4, f);
    pause(5);
        clear sound;
sound(output5, f);
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
    output1 = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input11);
    for n = 1:5
        output1 = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output1));
    end
    H(t) = output1(end)./input11(end);  % at the steady state
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
    output1 = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input11);
    for n = 1:10
        output1 = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output1));
        output1 = filter([1,-1],[1,(((1/f)/tau)-1)],output1);
    end
    H(t) = output1(end)./input11(end);  % at the steady state
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
    input11 = exp(i.*w_range(t).*time); % output vector
    output1 = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input11);
    for n = 1:10
        output1 = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output1));
        output1 = filter([1,-1],[1,(((1/f)/tau)-1)],output1);
    end
    H(t) = output1(end)./input11(end);  % at the steady state
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
    output1 = filter((1/f)/tau,[1,(((1/f)/tau)-1)],input11);
    for n = 1:10
        output1 = (filter((1/f)/tau,[1,(((1/f)/tau)-1)],output1));
        output1 = filter([1,-1],[1,(((1/f)/tau)-1)],output1);
    end
    H(t) = output1(end)./input11(end);  % at the steady state
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
    output1 = filter([1,-1],[1,(((1/f)/tau)-1)],input11);
    for n = 1:10
        output1 = filter([1,-1],[1,(((1/f)/tau)-1)],output1);
    end
    H(t) = output1(end)./input11(end);  % at the steady state
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
