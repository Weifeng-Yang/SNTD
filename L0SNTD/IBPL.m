%%  All parameters of this function are explained the same as 'main_Run_me' and 'ALGOchoose' functions
function [core,var,loss,timerun,bts]=IBPL(core,var,ngmar,coreaa,aa,maxiteropt,num,N,stopindex,r)
%% initialization algorithm
loss=[];
timerun=[0];
for i=1:num
    varze{i}=zeros(size(ngmar,i),N(i));
end
coreze=zeros(size(core));
bts=[];
varK=var;
coreK=core;
fprintf("nonzero:%d\n",nnz(core)); 
for j=1:num
    fprintf("nonzero:%d\n",nnz(var{j}));
end
tk=1;
bt=(tk-1)/tk;
returnloss=norm(tensor(ngmar));
loss(1)=compute(core,var,ngmar);


t1=clock;

for i=1:maxiteropt
%% update parameters
fprintf("%d\n",i);
[core,var,coreK,varK]=IBPLparaupdate(core,var,coreze,varze,num,ngmar,coreaa,aa,r,bt,coreK,varK);
loss(i+1)=compute(core,var,ngmar);
fprintf("IBPL\n");
%% Judging whether to extrapolate    
check=0;
for j=1:num
    check=check+norm(var{j}-varK{j},'fro')^2;
end
check=check+norm(tensor(core-coreK))^2;
if(loss(i+1)>loss(i)+(1e-100)*check)
    var=varK;
    core=coreK;
    [core,var,coreK,varK]=IBPLparaupdate(core,var,coreze,varze,num,ngmar,coreaa,aa,r,0,coreK,varK);
    loss(i+1)=compute(core,var,ngmar);
end



bts(i)=bt;


%% Check if termination condition is met
fprintf("nonzero:%d\n",nnz(core)); 
for j=1:num
    fprintf("nonzero:%d\n",nnz(var{j}~=0));   
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
bt=(tk-1)/(tk);

end




end















