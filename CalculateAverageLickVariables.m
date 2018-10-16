function [ILI,IBI,NumLicks,NumBouts,AvLickRate] = CalculateAverageLickVariables(licktimes,SessionDuration)

NumLicks = length(licktimes);
AvLickRate = NumLicks/SessionDuration;

