clearvars
clc
warning('off');
% Parameter.
%   SR        : Noise level for Synthetic datasets. Sampling rate of the data set for real datasets
%   index     : The data set to be used, when index=1, use the first synthetic dataset with noise, where the dimensions are: 100x100x100 
%               when index=2, use the second synthetic dataset with noise, where the dimensions are: 10x10x100x1000
%   r         : Step factor
%   maxiteropt: Maximum iteration alloted to the algorithm
%   trigger   : Whether to enable the indicator array of each algorithm, where
%               when 1∈trigger, enable the PALM algorithm
%               when 2∈trigger, enable the APG algorithm
%               when 3∈trigger, enable the IBPG algorithm
%               when 4∈trigger, enable the IBPL algorithm
%   percore   ：The proportion of non-zero elements allowed in core tensor
%   percent   ：The proportion of non-zero elements allowed in each decomposition matrix
%   stopindex : The indicator of the stop condition.  
%               To set the specific termination condition, see the 'stopcheck' function for details.  
%               The default termination condition is: each algorithm runs for 30 secondss

%% Parameter settings
rng('shuffle')
index=2;
r=1.1;
maxiteropt=600000;
trigger=[1,2,3,4];
percent=0.5;
percore=0.3;
stopindex=1;


%% Select dataset
[ngmar,num,N]=readfile(index);

%% Init
for i=1:length(size(ngmar))
    a(i)=N(i)*size(ngmar,i)*percent;
end
aa=a;
for i=1:num
    den=size(ngmar,i)*N(i);
    var{i}=sprand(size(ngmar,i),N(i),aa(i)/den);
    var{i}=full(var{i});
end

core=zeros(N);
coreaa=prod(size(core))*percore;
core=sptenrand(size(core),coreaa);
core=tensor(core);

%% Solving
for i=1:length(trigger)
[datas{i},varss{i}]=ALGOchoose(core,var,ngmar,coreaa,aa,maxiteropt,num,N,trigger(i),stopindex,r);
end
var{num+1}=core;
datas{length(trigger)+1}=varss;
datas{length(trigger)+2}=var;

%% Drawing
plt0=plotplt(datas,trigger);










