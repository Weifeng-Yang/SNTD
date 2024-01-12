%% All parameters of this function are explained the same as 'main_Run_me' and 'ALGOchoose' functions
function [core,var,loss,timerun,bts,ats]=IBPG(core,var,ngmar,coreaa,aa,maxiteropt,num,N,stopindex,r)
%% initialization algorithm
loss=[];
timerun=[0];
for i=1:num
    varze{i}=zeros(size(ngmar,i),N(i));
end
coreze=zeros(size(core));
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
randsor=randperm(num+1);
randlen=2;
randsor=repmat(randsor,1,randlen);
LtempK=LK;
LCtempK=LCK;
vartempK=varK;
coretempK=coreK;
varK=var;
coreK=core;
LK=L;
LCK=LC;

[core,var,LC,L,at,bt,atc,btc]=IBPGcupdate(core,var,coreze,coreaa,coretempK,varze,aa,vartempK,num,ngmar,randsor,LC,LCtempK,L,LtempK,r,wk);
loss(i+1)=compute(core,var,ngmar);
bts{i}=[btc,bt];
ats{i}=[atc,at];


%% Check if termination condition is met
fprintf("IBPG\n");
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
tk=(1+sqrt(1+4*tk^2))/2;
wk=(tk-1)/(tk);
end




end













