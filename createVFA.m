function FAs = createVFA(FAinit, FAmax, length)
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
    
    figure, plot(FAs);
    xlabel('#Interleaves')
    ylabel('Flip Angle')
        
end