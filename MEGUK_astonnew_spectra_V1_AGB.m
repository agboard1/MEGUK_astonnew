%% MEGUK ASTON NEW: Spectral (manual)
%ABoard v1
%23/01/2020


close all;
clear all;
restoredefaultpath
clc;

%%
addpath('/home/aboard/Documents/software/toolbox/');
addpath('/home/aboard/Documents/MATLAB/osl/osl-core');
osl_startup;

%% Linux LOAD DIRECTORIES
workingdir = '/home/aboard/Documents/MEGUK/data/';

%% Get data

Dname = getfullpath(fullfile(workingdir,sprintf('sub-astnew*'))); %% Need to change getfullpath function depending on what v.matlab
Dname = dir(Dname);

%% dsub-astnew*_task-resteyesopen_meg.mat

for i = [1:15, 17:38, 40:42, 44:47, 49:73]  %length(Dname)       %error in subj16, subj39 subj43 subj48

    pxx = zeros(length(Dname),257,204); % Aston New n=73 %create array to save power spectrum to

    temp_open    = 'dsub-astnew%03d_task-resteyesopen_meg.mat'; %Create template to load subject level data
    temp_closed  = 'dsub-astnew%03d_task-resteyesclosed_meg.mat';
%   fpath_open   = fullfile(workingdir, sprintf(temp_open,i));
%   fpath_closed = fullfile(workingdir, sprintf(temp_closed,i));

    D_open   = spm_eeg_load(fullfile(workingdir, Dname(i).name, sprintf(temp_open,i))); %Loads open and closed .mat files
    D_closed = spm_eeg_load(fullfile(workingdir, Dname(i).name, sprintf(temp_closed,i)));
    fprintf([Dname(i).name, '...\n']) % Print the current subject

    chaninds = D_open.indchantype('MEGPLANAR');

    good_open = find(good_samples(D_open));
    [pxx_open(i,:,:),f] = pwelch( D_open(chaninds,good_open,1)', D_open.fsample,[],[],D_open.fsample);

    good_closed = find(good_samples(D_closed));
    [pxx_closed(i,:,:),f] = pwelch( D_closed(chaninds,good_closed,1)', D_closed.fsample,[],[],D_closed.fsample);

%% Plotting

    %Plotting

    figure();
    subplot(1,1,1);
    grid on;
    hold on;
    plot(f,squeeze(mean(pxx_open(i,:,:),3)),'linewidth',2);
    plot(f,squeeze(mean(pxx_closed(i,:,:),3)),'linewidth',2);
    legend({'open','closed'});
    title([Dname(i).name]);
    uiwait %Close the plot and move to the next.

end

    %Add figure which plots all subjects onto one plot

    figure(); hold on
    grid on;
    for i = 1:length(Dname)
        plot(f,squeeze(mean(pxx_open(i,:,:),3)),'linewidth',2, 'color','m');
        plot(f,squeeze(mean(pxx_closed(i,:,:),3)),'linewidth',2, 'color','b');
        legend({'open','closed'});
    end
    hold off
