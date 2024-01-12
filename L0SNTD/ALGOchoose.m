
%% Input.
% var,core    : Initial matrix and core tensor
% ngmar       : Decomposed tensor
% coreaa,aa   : Maximum number of non-zero elements for each decomposition matrix and core tensor
% The remaining Parameters are explained the same as the 'main_Run_me' function

%% Output.
% cores, vars : Decomposition matrix and core tensor resulting from the final iterative result
% loss:       : Array of loss functions generated during iteration
% tr:         : Runtime array during iteration
% btss and atz: An array of extrapolated parameters produced by each algorithm during iteration
%             : where 'atz' represents the array of additional extrapolated parameters for IBPG and iPALM

function [data,varss]=ALGOchoose(core,var,ngmar,coreaa,aa,maxiteropt,num,N,flag,stopindex,r)
if(flag==1)
[cores,vars,loss,tr,btss]=PALM(core,var,ngmar,maxiteropt,num,stopindex,r,0.5);
varss{1}=cores;
varss{2}=vars;
lossdata{1}=loss;
trdata{1}=tr;
btz{1}=btss;




elseif(flag==2)
[cores,vars,loss,tr,btss]=APG(core,var,ngmar,maxiteropt,num,stopindex,r,0.5);
varss{1}=cores;
varss{2}=vars;
lossdata{1}=loss;
trdata{1}=tr;
btz{1}=btss;


elseif(flag==3)
[cores,vars,loss,tr,btss,atz]=IBPG(core,var,ngmar,coreaa,aa,maxiteropt,num,N,stopindex,r);
varss{1}=cores;
varss{2}=vars;
lossdata{1}=loss;
trdata{1}=tr;
btz{1}=btss;
datas{4}=atz;


elseif(flag==4)
[cores,vars,loss,tr,btss]=IBPL(core,var,ngmar,coreaa,aa,maxiteropt,num,N,stopindex,r);  
varss{1}=cores;
varss{2}=vars;
lossdata{1}=loss;
trdata{1}=tr;
btz{1}=btss;

end


data{1}=lossdata;
data{2}=trdata;
data{3}=btz;


end
