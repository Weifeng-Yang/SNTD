function check=plotplt(datas,trigger)
color=["-o","-*","-^","-x","-p","-d","->"];
% color=["-o","-*","-+","-x","-p","-d","->"];
mess={};
check=0;
for i=1:length(trigger)
data=datas{i};
lossdata=data{1};
lossdata=lossdata;
trdata=data{2};

if(~isempty(lossdata))
    mess=pltplt(lossdata,trdata,trigger(i),mess,color(i));
end
end
end

function mess=pltplt(lossdata,trdata,trigger,mess,color)
figure(1)
% color=["-o","-*","-+","-x","-d","-s","-p","-h"];

ss=40;
for i=1:length(lossdata)
    maker_idx = 1:ss:length(lossdata{i});
            loss=lossdata{i};
    semilogy(trdata{i},loss,color,'linewidth',0.9,'MarkerIndices',maker_idx);
    xlabel('Time (seconds)','FontSize',60);
    ylabel('Objective funciton value','FontSize',60);
    if(trigger==1)
     mes{i}='$PALM$';
    elseif(trigger==2)
    mes{i}='$APG$';
   elseif(trigger==3)
    mes{i}='$IBPG$';
    elseif(trigger==4)
    mes{i}='$IBPL$';
    end
    hold on;
end
ls=length(mess);
for j=1:length(mes)
    mess{j+ls}=mes{j};
end
h=legend(mess,'Interpreter','latex');
set(gca,'FontSize',50);
set(h,'FontSize',60)
xlabel('Time (seconds)','FontSize',60);
ylabel('Objective funciton value','FontSize',60);
% prettyAxes().gbase2()
    plt0=0;
end

