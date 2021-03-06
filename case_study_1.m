%% Task 1 - process "Giant Steps" by John Coltrane and "Space Station" by Art Farmer

% Set up the parameters
c_l = [3.42E-6, 1.759E-6,  1.31e-6,  5.41e-7, 5.31e-7];    
r_l = [60, 60, 60, 60, 60];
c_h = [3.32E-6, 3.22E-6, 1.559E-6,  1.11e-6, 5.41e-7];    
r_h = [60, 60, 60, 60, 60];

order = [10, 10, 10, 10, 10];

magnitude_unity  = [1 50 200 20 1/6];
% magnitude_unity  = [0 0 0 1 0];
magnitude_base_boost = [1 6.5 1.27 9.17 1];
magnitude_treble_boost = [1 6.5 1.27 9.17 1];
type = ['l', 'x', 'x' , 'x', 'h'];


% Process"Giant Steps"

[output1_gs, new_fs_gs] = freqSep("Giant Steps Bass Cut.wav", r_l, c_l, r_h, c_h, order, magnitude_unity, type); 

% Process "Space Station"

% [output1_ss, new_fs_ss] = freqSep("Space Station - Treble Cut.wav", r_l, c_l, r_h, c_h, order, magnitude_unity,  type); 


sound(output1_gs, new_fs_gs);
    pause(5);
        clear sound;
% sound(output1_ss, new_fs_ss);
%     pause(5);
%         clear sound;




  %% Task 2 Clear the siren in "Blue in Green" by Miles Davis First Trial

% Process "Blue in Green"
magnitude_eliminate_siren= [1 0 1.27 0 1];
[output1_bg, new_fs_bg] = freqSep("Blue in Green with Siren.wav", r_l, c_l, r_h, c_h, order, magnitude_eliminate_siren,  type); 

sound(output1_bg, new_fs_bg);
    pause(5);
        clear sound;

%% Task 2  Second Trial
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


