%% Matrix's gradient calculation function
function [V,L,U]=grad1(core,var,ngmar,r,n,num)
core=tensor(core);
index=1:num;
index(n)=[];
coreg=ttm(core,var,index);
tempB=double(tenmat(coreg,n));
temp=tempB*tempB';
Xn=double(tenmat(ngmar,n));
U=var{n}*temp-Xn*tempB';
L=norm(temp,'fro');
V=var{n}-1/(r*L)*U;
end