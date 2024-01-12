%%  All parameters of this function are explained the same as 'main_Run_me' and 'ALGOchoose' functions
function [core,var,loss,timerun,bts]=APG(core,var,ngmar,maxiteropt,num,stopindex,r,lamda)
%% initialization algorithm
loss=[];
timerun=[0];
LK=zeros(1,num);
LCK=0;
L=ones(1,num);
LC=1;
tk=1;
varK=var;
coreK=core;
wk=(tk-1)/(tk);

returnloss=norm(tensor(ngmar));
loss(1)=compute(core,var,ngmar);


t1=clock;


for i=1:maxiteropt
%% update parameters
fprintf("%d\n",i);
bt=zeros(1,num);
btc=0;

for j=1:num
LtempK=LK;
LCtempK=LCK;
vartempK=varK;
coretempK=coreK;    
varK=var;
coreK=core;
LK=L;
LCK=LC;    
[core,var,LC,L,btc,bt]=APGupdate(core,var,coretempK,vartempK,num,ngmar,r,wk,L,LC,LtempK,LCtempK,lamda,j);
loss(i+1)=compute(core,var,ngmar);


%% Judging whether to extrapolate
if(loss(i+1)>=loss(i))
    var=varK;
    core=coreK;
    L=LK;
    LC=LCK;
    [core,var,LC,L]=APGupdate(core,var,coretempK,vartempK,num,ngmar,r,0,L,LC,LtempK,LCtempK,lamda,j);
    loss(i+1)=compute(core,var,ngmar);
end
end


%% Check if termination condition is met
fprintf("APG\n");
fprintf("nonzero:%d\n",nnz(core));  
for j=1:num
    fprintf("nonzero:%d\n",nnz(var{j}));  
end

bts{i}=[btc,bt];
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

tk=(1+sqrt(1+4*tk^2))/2;
wk=(tk-1)/(tk);



end




end













