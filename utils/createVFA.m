function FAs = createVFA(FAinit, FAmax, length)
% function FAs = createVFA(FAinit, FAmax, length)
% 
% [Aim]: to create a initial FAs with triangle shape
%
% Input:
%   FAinit: initila FA
%   FAmax : max FA
%   length: length of FAs
%
% Output:
%   FAs: calculated FA
%

    FAs = zeros(length,1);
    if mod(length, 2) == 0
        FAs(length/2,1) = FAmax;
        for i = 1:length/2
            FAs(i, 1) = (FAmax - FAinit)/(length/2)*(i-1) + FAinit;
        end
        FAs(length/2+1:end, :) = flip(FAs(1:length/2,1));
    else
        FAs((length-1)/2 + 1,1) = FAmax;
        for i = 1:(length-1)/2 + 1
            FAs(i, 1) = (FAmax - FAinit)/((length-1)/2)*(i-1) + FAinit;
        end
        FAs((length-1)/2+2:end, :) = flip(FAs(1:(length-1)/2,1));
    end
    
    figure, plot(rad2deg(FAs));
    xlabel('#Interleaves')
    ylabel('Flip Angle')
        
end