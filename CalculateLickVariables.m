function [BoutDurations,NumLicksInBouts,LickRates,MeanILIs,BoutStartTimes,BoutEndTimes] = CalculateLickVariables(licktimes,IBIThreshold)

NumLicksInCurrentBout = 0;
CurrentBoutNumber = 0;
BoutDurations = [];
NumLicksInBouts = [];
LickRates = [];
MeanILIs = [];
BoutStartTimes = [];
BoutEndTimes = [];

for i = 1 %determine whether first lick is single lick or first lick of a bout
    
    upcominglickgap = licktimes(i+1)-licktimes(i); % gap between first and second lick
    
    if upcominglickgap < IBIThreshold %lick is first of bout (else it is a single lick)
        CurrentBoutNumber = CurrentBoutNumber + 1;
        NumLicksInCurrentBout = NumLicksInCurrentBout + 1;
        BoutStartTime = licktimes(i);
    end
end
    
    
for i = 2:length(licktimes)-1 % determine whether licks 2 to end-1 are single licks, first licks of a bout, or licks within a bout
    
    %determine time interval between the current lick and the previous lick
    
    prevlickgap = licktimes(i) - licktimes(i-1);
    
    %determine time interval between upcoming lick and the previous lick
    
    upcominglickgap = licktimes(i+1) - licktimes(i);
    
    if prevlickgap >= IBIThreshold && upcominglickgap >= IBIThreshold %single lick
        
        % do nothing
        
    elseif prevlickgap >= IBIThreshold && upcominglickgap < IBIThreshold %lick is first of bout (else it is a single lick)
        CurrentBoutNumber = CurrentBoutNumber + 1;
        NumLicksInCurrentBout = NumLicksInCurrentBout + 1;
        BoutStartTimes(CurrentBoutNumber) = licktimes(i);
    
    elseif prevlickgap < IBIThreshold && upcominglickgap < IBIThreshold% lick is within a bout 

        NumLicksInCurrentBout = NumLicksInCurrentBout + 1;
    
    elseif prevlickgap < IBIThreshold && upcominglickgap >= IBIThreshold %last lick of bout

            % calculate all variables of the bout that is ending
            
                NumLicksInBouts(CurrentBoutNumber) = NumLicksInCurrentBout+1;
                BoutEndTimes(CurrentBoutNumber) = licktimes(i);
                BoutDurations(CurrentBoutNumber) = licktimes(i)-BoutStartTimes(CurrentBoutNumber);
                LickRates(CurrentBoutNumber) = (NumLicksInCurrentBout+1)/BoutDurations(CurrentBoutNumber);
                MeanILIs(CurrentBoutNumber) = BoutDurations(CurrentBoutNumber)/(NumLicksInCurrentBout+1);
        
    end
    
end

for i = length(licktimes)
        
    %determine time interval between the current lick and the previous lick
    
    prevlickgap = licktimes(i) - licktimes(i-1);
    
    if prevlickgap >= IBIThreshold %single lick
        
        % do nothing        
        
    elseif prevlickgap < IBIThreshold %last lick of (recorded) bout
                BoutEndTimes(CurrentBoutNumber) = licktimes(i);
                BoutDurations(CurrentBoutNumber) = licktimes(i)-BoutStartTimes(CurrentBoutNumber);
                NumLicksInBouts(CurrentBoutNumber) = NumLicksInCurrentBout+1;
                LickRates(CurrentBoutNumber) = (NumLicksInCurrentBout+1)/BoutDurations(CurrentBoutNumber);
                MeanILIs(CurrentBoutNumber) = BoutDurations(CurrentBoutNumber)/(NumLicksInCurrentBout+1);
    end
end

        
 
        