%% MEGUK ASTON NEW: AFRICA (manual)
%ABoard v2
%22/11/2019

close all;
clear all;
restoredefaultpath
clc;

%% Linux Setup
addpath('/home/aboard/Documents/software/toolbox/');
addpath('/home/aboard/Documents/MATLAB/osl/osl-core');
osl_startup;
 
%% Linux LOAD DIRECTORIES
workingdir = '/home/aboard/Documents/MEGUK/data/';
outdir     = '/home/aboard/Documents/MEGUK/preprocessed_data/';

%% Setup 
pause on; % are you ready to begin? 

%% Mac
% addpath ('/Users/Alex/Documents/programming/matlab_toolboxes/meg/osl2.2.0/osl-core/');
% osl_startup;
% Mac LOAD Directories
% workingdir = '/Users/Alex/Documents/university_of_oxford/MEGUK/tmp_data/';

%% RESTEYES OPEN: AstNew n=73

% change to 'true' to run this loop.
if false 

%Get Data: Data has been preprocessed inc auto ICA, beamforming, bad segments, downsampling. 
Dname = getfullpath(fullfile(workingdir,sprintf('sub-astnew*/dsub-astnew*_task-resteyesopen_meg.mat'))); %% Need to change getfullpath function depending on what v.matlab
Dname = dir(Dname);

%while loop setup (if needed)
%looper = 1;
%while(looper) %adds a catch after AFRICA plots to ensure happy with manual AFRICA.

for i= 1:length(Dname) % change as needed! 

%Load and print data. N.B. remember the files structure and how im parsing.    
    D = spm_eeg_load(fullfile(Dname(i).folder, Dname(i).name));
    fprintf(Dname.name, '%s\n', workingdir)
    oslview(D) %View bad segments and remove additional bad segments. 

%Remove the montage from the D object
    for k = 1:numel(D) %make sure numel is correct here.
       if strcmp(D.montage('getname') , 'AFRICA denoised data')
        D = D.montage('remove', 1:D.montage('getnumber')); %% Removes montage from previous auto ICA, must always be removed before manual AFRICA
       end
       
%Manual AFRICA       
    D = osl_africa(D,'do_ica', true, 'do_ident', false, 'do_remove', false, 'used_maxfilter', true);
    D = osl_africa(D,'used_maxfilter',1,'do_ident','manual');

%View the power spectrum and topo post AFRICA 
    osl_quick_spectra(D)
    has_montage(D)
    D_pre_africa = D.montage('switch', 0);
    D_africa = D.montage('switch', 1);
    
%Plot ECG: Compare pre AFRICA and post AFRICA. 
    figure;
    subplot(2,1,1)
    plot(D_pre_africa.time(1:10000), D_pre_africa(308,1:10000));
    title('ECG Channel');
    xlim([10 20]);
    xlabel('Time (s)');
    
    subplot(2,1,2)
    plot(D_pre_africa.time(1:10000), D_pre_africa(306,1:10000));
    title('ECG Contaminated channel');
    xlim([10 20]);
    hold on; 
    plot(D_africa.time(1:10000), D_africa(306,1:10000), 'r');
    xlim([10 20]);
    xlabel('Time (s)');
    legend({'pre AFRICA', 'post AFRICA'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    
%Are we happy with AFRICA?? %% Maybe create a function. 
    p = input('Happy? Y/N [Y]:','s');
    if p == 'N'
        oslview(D) %Look fo
        D = osl_africa(D,'do_ica', true, 'do_ident', false, 'do_remove', false, 'used_maxfilter', true);
        D = osl_africa(D,'used_maxfilter',1,'do_ident','manual'); 
        
        %If NO: AFRICA re-opens. 

    %recreates the montages
        has_montage(D)
        D_pre_africa = D.montage('switch', 0);
        D_africa = D.montage('switch', 1);

    %Re-Plot ECG: Compare pre AFRICA and post AFRICA (newest one).
        figure;
        subplot(2,1,1)
        plot(D_pre_africa.time(1:10000), D_pre_africa(308,1:10000));
        title('ECG Channel');
        xlim([10 20]);
        xlabel('Time (s)');

        subplot(2,1,2)
        plot(D_pre_africa.time(1:10000), D_pre_africa(306,1:10000));
        title('ECG Contaminated channel');
        xlim([10 20]);
        hold on; 
        plot(D_africa.time(1:10000), D_africa(306,1:10000), 'r');
        xlim([10 20]);
        xlabel('Time (s)');
        legend({'pre AFRICA', 'post AFRICA'});
     end
   
    D.save()
    end   

end 
end

%looper = 0; 

pause %before it goes onto resteyesclosed. press any key to continue. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RestEyesClosed AstNew n=73

% change to 'true' to run this loop.
if true

%Get Data: Data has been preprocessed inc auto ICA, beamforming, bad segments, downsampling. 
Dname = getfullpath(fullfile(workingdir,sprintf('sub-astnew*/dsub-astnew*_task-resteyesclosed_meg.mat'))); %% Need to change getfullpath function depending on what v.matlab
Dname = dir(Dname);

%while loop setup (if needed)
%looper = 1;
%while(looper) %adds a catch after AFRICA plots to ensure happy with manual AFRICA.

for i= 70:length(Dname)
     
%Load and print data. N.B. remember the files structure and how im parsing.    
    D = spm_eeg_load(fullfile(Dname(i).folder, Dname(i).name));
    fprintf(Dname.name, '%s\n', workingdir)
    oslview(D) %View bad segments and remove additional bad segments. 

%Remove the montage from the D object
    for k = 1:numel(D) %make sure numel is correct here.
       if strcmp(D.montage('getname') , 'AFRICA denoised data')
        D = D.montage('remove', 1:D.montage('getnumber')); %% Removes montage from previous auto ICA, must always be removed before manual AFRICA
       end
       
%Manual AFRICA       
    D = osl_africa(D,'do_ica', true, 'do_ident', false, 'do_remove', false, 'used_maxfilter', true);
    D = osl_africa(D,'used_maxfilter',1,'do_ident','manual');

%View the power spectrum and topo post AFRICA 
    osl_quick_spectra(D)
    has_montage(D)
    D_pre_africa = D.montage('switch', 0);
    D_africa = D.montage('switch', 1);
    
%Plot ECG: Compare pre AFRICA and post AFRICA. 
    figure;
    subplot(2,1,1)
    plot(D_pre_africa.time(1:10000), D_pre_africa(308,1:10000));
    title('ECG Channel');
    xlim([10 20]);
    xlabel('Time (s)');
    
    subplot(2,1,2)
    plot(D_pre_africa.time(1:10000), D_pre_africa(306,1:10000));
    title('ECG Contaminated channel');
    xlim([10 20]);
    hold on; 
    plot(D_africa.time(1:10000), D_africa(306,1:10000), 'r');
    xlim([10 20]);
    xlabel('Time (s)');
    legend({'pre AFRICA', 'post AFRICA'});
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Are we happy with AFRICA?? %% Maybe create a function. 
    p = input('Happy? Y/N [Y]:','s');
    if p == 'N'
        oslview(D)
        D = osl_africa(D,'do_ica', true, 'do_ident', false, 'do_remove', false, 'used_maxfilter', true);
        D = osl_africa(D,'used_maxfilter',1,'do_ident','manual'); 
        
        %If NO: AFRICA re-opens. 

        %recreates the montages
        has_montage(D)
        D_pre_africa = D.montage('switch', 0);
        D_africa = D.montage('switch', 1);
    
        %Re-Plot ECG: Compare pre AFRICA and post AFRICA (newest one).
        figure;
        subplot(2,1,1)
        plot(D_pre_africa.time(1:10000), D_pre_africa(308,1:10000));
        title('ECG Channel');
        xlim([10 20]);
        xlabel('Time (s)');

        subplot(2,1,2)
        plot(D_pre_africa.time(1:10000), D_pre_africa(306,1:10000));
        title('ECG Contaminated channel');
        xlim([10 20]);
        hold on; 
        plot(D_africa.time(1:10000), D_africa(306,1:10000), 'r');
        xlim([10 20]);
        xlabel('Time (s)');
        legend({'pre AFRICA', 'post AFRICA'});
     end
    
    
    D.save()
    end
    
end   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 



