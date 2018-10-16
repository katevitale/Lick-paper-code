% script to calculate licking variables given lick timestamps

% input is an excel file of lick timestamps 
sourcepath = '/Users/Kate/Documents/MATLAB/Woody/xls files to analyze';
outputfilename = '/Users/Kate/Documents/MATLAB/Woody/xls files with output/output.xls';
data=[];
labels={};

source_dir = sourcepath;
dest_dir = outputfilename;
source_files = dir(fullfile(source_dir, '*.xls'));
for i = 1:length(source_files)
  data = xlsread(fullfile(source_dir, source_files(i).name));
  data = data(:,3:7);
  data=data';
  licktimes(i,)= data(:);
  licktimes=licktimes(~isnan(licktimes));
  
end

IBIThreshold = 1;

[BoutDurations,NumLicksInBouts,LickRates,MeanILIs,BoutStartTimes,BoutEndTimes] = CalculateLickVariables(licktimes,IBIThreshold); 

BoutStartTimes=BoutStartTimes';
BoutEndTimes=BoutEndTimes';
BoutDurations=BoutDurations';
NumLicksInBouts=NumLicksInBouts';
LickRates=LickRates';
MeanILIs=MeanILIs';

T = table(BoutStartTimes,BoutEndTimes,BoutDurations,NumLicksInBouts,LickRates,MeanILIs);

writetable(T,outputfilename)




