%% Parameter update function of algorithm APG
function [core,var,LC,L,btc,bt]=APGupdate(core,var,coreK,varK,num,ngmar,r,wk,L,LC,LK,LCK,lamda,j)

    btc=min(wk,0.99*sqrt(LCK/LC));
    core=core+btc*(core-coreK);
    [V,LC]=gradcore(core,var,ngmar,r,num);
    core=PROXn(V,lamda,1/(LC*r));

    bt(j)=min(wk,0.99*sqrt(LK(j)/L(j)));
    var{j}=var{j}+bt(j)*(var{j}-varK{j});
    [V,L(j)]=grad1(core,var,ngmar,r,j,num);
    var{j}=PROXn(V,lamda,1/(L(j)*r));
end

function x=PROXn(U,lamda,tao)

U=double(U);
indbig=find(U>tao*lamda);
indsmall=find(U<-tao*lamda);
x=zeros(size(U));
x(indbig)=U(indbig)-tao*lamda;
x(indsmall)=U(indsmall)+tao*lamda;
x(x<0)=0;
end


