%% Termination condition checking function.
% threshold            : Termination threshold
% timerun(end)>timeend : Where 'timeend' refers to the termination running time

function stop=stopcheck(Res,timerun,stopindex)
    stop=0;
    threshold=1e-8;
     if(stopindex==1)
        if(timerun(end)>30) % This statement means is: when the running time exceeds 30 seconds, the program terminates.
        stop=1;
        end

     elseif(stopindex==2)
        if(timerun(end)>100) % This statement means is: when the running time exceeds 100 seconds, the program terminates.
        stop=1;
        end
    elseif(stopindex==3)
        if(Res<threshold)
        stop=1;
        end
    end
end
