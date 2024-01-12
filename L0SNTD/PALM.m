%%  All parameters of this function are explained the same as 'main_Run_me' and 'ALGOchoose' functions
function [core,var,loss,timerun,bts]=PALM(core,var,ngmar,maxiteropt,num,stopindex,r,lamda)
%% initialization algorithm
loss=[];
timerun=[0];
bts=0;
returnloss=norm(tensor(ngmar));
loss(1)=compute(core,var,ngmar);
t1=clock;


for i=1:maxiteropt
%% update parameters
fprintf("%d\n",i);
varK=var;
coreK=core;
[core,var]=PALMupdate(core,var,num,ngmar,r,lamda);
loss(i+1)=compute(core,var,ngmar);


%% Check if termination condition is met
fprintf("PALM:\n");
fprintf("nonzero:%d\n",nnz(core));
for j=1:num
    fprintf("nonzero:%d\n",nnz(var{j}));
end
t2=clock;
timerun(i+1)=etime(t2,t1);
ReeK=loss(i)/returnloss;
Ree=loss(i+1)/returnloss;
Res=abs(Ree-ReeK);
fprintf("cri：%d\n",Res);
stop=stopcheck(Res,timerun,stopindex);
if(stop==1)
    fprintf("Number of terminations：%d\n",i);
    pause(4);
    break;
end



end




end















