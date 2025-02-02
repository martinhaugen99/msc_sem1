%%%%%%%% script for calculating rms of the different velocities for both
%%%%%%%% passive and semi-active suspension

%clear;
%close all;
%clc;


%% calling rms function

rms_10_pass = rms(data10kmh.passive)
rms_10_act = rms(data10kmh.semi)

rms_40_pass = rms(data40kmh.passive)
rms_40_act = rms(data40kmh.semi)

rms_130_pass = rms(data130kmh.passive)
rms_130_act = rms(data130kmh.semi)