function [BoutDurations,NumLicksInBouts,LickRates,MeanILIs,BoutStartTimes,BoutEndTimes] = FindBouts(licktimes,IBIThreshold)

NumLicksInCurrentBout = 0;
CurrentBoutNumber = 0;
BoutDurations = [];
NumLicksInBouts = [];
LickRates = [];
MeanILIs = [];
BoutStartTimes = [];
BoutEndTimes = [];

for i = 1 %determine whether first lick is single lick or first lick of a bout
    
    upcominglickgap = licktimes(i+1)-licktimes(i);
    
    if upcominglickgap < IBIThreshold %lick is first of bout (else it is a single lick)
        BoutStartTime = licktimes(i);
        NumLicksInCurrentBout = NumLicksInCurrentBout + 1;
        CurrentBoutNumber = CurrentBoutNumber + 1;
    end
end
    
    
for i = 2:length(licktimes) % determine whether licks 2 to end are single licks, first licks of a bout, or licks within a bout
    
    prevlickgap = licktimes(i) - licktimes(i-1);
    upcominglickgap = licktimes(i+1) - licktimes(i);
    
    if prevlickgap >= IBIThreshold && upcominglickgap >= IBIThreshold %single lick
        
        % do nothing
        
    elseif prevlickgap >= IBIThreshold && upcominglickgap < IBIThreshold %first lick of bout

            % if this is not the first bout, calculate all variables of last bout
            if CurrentBoutNumber >= 1 
                BoutEndTimes(CurrentBoutNumber) = licktimes(i-1);
                BoutDurations(CurrentBoutNumber) = licktimes(i-1)-BoutStartTimes(CurrentBoutNumber);
                NumLicksInBouts(CurrentBoutNumber) = NumLicksInCurrentBout;
                LickRates(CurrentBoutNumber) = NumLicksInCurrentBout/BoutDuration;
                MeanILIs(CurrentBoutNumber) = BoutDuration/NumLicksInCurrentBout;
            
            % if it IS the first bout, do nothing
            end 
                
            %update info for current bout
                NumLicksInCurrentBout = 1;
                CurrentBoutNumber = CurrentBoutNumber + 1;
                BoutStartTimes(CurrentBoutNumber) = licktimes(i);
                
    else % lick is within a bout (which includes the last lick of a bout)

        NumLicksInCurrentBout = NumLicksInCurrentBout + 1;
        
    end
    
end

        
        
 
        