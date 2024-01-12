%% Read data set function
%   N         : Rank of Tensor Tucker Decomposition
%   Nway      : Size of tensor 

function [ngmar,num,N]=readfile(i)
   if(i==1) 
   N=[10,10,10];
   Nway=[100,100,100];
   G = tensor(max(0,randn(N)));
    A = cell(1,ndims(G));
    % randomly generate factor matrices
    for i = 1:ndims(G)
    A{i} = max(0,randn(Nway(i),N(i)));
    end
    % generate tensor
    M = full(ttensor(G,A)); 
    M = tensor(M.data/max(M.data(:)));
    ngmar=M;
    num=length(N);

   elseif(i==2) 
   N=[3,3,3,50];
   Nway=[10,10,10,1000];
   G = tensor(max(0,randn(N)));
    A = cell(1,ndims(G));
    % randomly generate factor matrices
    for i = 1:ndims(G)
    A{i} = max(0,randn(Nway(i),N(i)));
    end
    % generate tensor
    M = full(ttensor(G,A)); 
    M = tensor(M.data/max(M.data(:)));
    ngmar=M;
    num=length(N);
   end 




   
end
