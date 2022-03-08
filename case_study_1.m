%% Task 1 - process "Giant Steps" by John Coltrane and "Space Station" by Art Farmer

% Set up the parameters
c_l = [1.567E-5, 5.63e-6,  2.142e-6,  7.055e-7, 3.655e-6];    
r_l = [60, 60, 60, 60, 60];
c_h = [1.667E-4, 1.667E-4, 4.63e-5, 1.142e-5, 3.655e-6];    
r_h = [60, 60, 60, 60, 60];

order = [11, 11, 11, 10, 10];
magnitude_unity  = [1 0.8 1.4 1.43 0.78 ];
magnitude_base_boost = [4 3 1.4 1.43 0.78 ];
magnitude_treble_boost = [1 0.8 1.4 3 2.5 ];
type = ['l', 'x', 'x' , 'x', 'h'];


% Process"Giant Steps"

% [output1_gs, new_fs_gs] = freqSep("Giant Steps Bass Cut.wav", r_l, c_l, r_h, c_h, order, magnitude_base_boost, type); 

% Process "Space Station"

% [output1_ss, new_fs_ss] = freqSep("Space Station - Treble Cut.wav", r_l, c_l, r_h, c_h, order, magnitude_unity,  type); 


% Process "Blue in Green"
magnitude_eliminate_siren= [1 0.2 0.5 0.5 0.2 ];
[output1_bg, new_fs_bg] = freqSep("Blue in Green with Siren.wav", r_l, c_l, r_h, c_h, order, magnitude_eliminate_siren,  type); 


% sound(output1_gs, new_fs_gs);
%     pause(5);
%         clear sound;
% sound(output1_ss, new_fs_ss);
%     pause(5);
%         clear sound;
sound(output1_bg, new_fs_bg);
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


