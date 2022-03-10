%% Task 1 - process "Giant Steps" by John Coltrane and "Space Station" by Art Farmer

% Set up the parameters
c_l = [3.22E-6, 0.809E-6,  0.70e-6,  2.41e-7, 6.81e-7];    
r_l = [60, 60, 60, 60, 60];
c_h = [3.32E-6, 1.82E-5, 6.559E-6,  2.495e-6, 6.81e-7];    
r_h = [60, 60, 60, 60, 60];

order = [10, 5, 5, 5, 5];

magnitude_unity  = [1 0.78  0.4 0.77 0.652];
magnitude_base_boost = [2 1.48  0.5 0.57 0.652];
magnitude_treble_boost = [1 0.78  0.4 1.47 1.552];
type = ['l', 'x', 'x' , 'x', 'h'];


% Process"Giant Steps"

[output1_gs, new_fs_gs] = freqSep("Giant Steps Bass Cut.wav", r_l, c_l, r_h, c_h, order, magnitude_unity, type);

% Process "Space Station"

[output1_ss, new_fs_ss] = freqSep("Space Station - Treble Cut.wav", r_l, c_l, r_h, c_h, order, magnitude_treble_boost,  type); 


sound(output1_gs, new_fs_gs);
    pause(5);
        clear sound;
sound(output1_ss, new_fs_ss);
    pause(5);
        clear sound;




  %% Task 2 Clear the siren in "Blue in Green" by Miles Davis First Trial

% Process "Blue in Green"
magnitude_eliminate_siren= [1 0 0 0 0];
[output1_bg, new_fs_bg] = freqSep("Blue in Green with Siren.wav", r_l, c_l, r_h, c_h, order, magnitude_eliminate_siren,  type); 

sound(output1_bg, new_fs_bg);
    pause(5);
        clear sound;

%% Task 3 Improve the ESE 351 class audio
analyze('tro.mp4'); 

% Set up the parameters

magnitude_unity  = [2 1.78  1.4 0.77 0.652];
[output_tro, new_fs_tro] = freqSep('tro.mp4', r_l, c_l, r_h, c_h, order, magnitude_unity, type); 

sound(output_tro, new_fs_tro);
    pause(5);
        clear sound;


