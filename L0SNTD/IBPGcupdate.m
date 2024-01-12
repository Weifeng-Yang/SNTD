%% Parameter update function of algorithm IBPG
function [core,var,LC,L,at,bt,atc,btc]=IBPGcupdate(core,var,coreze,coreaa,coreK,varze,aa,varK,num,ngmar,randsor,LC,LCK,L,LK,r,wk)
    at=zeros(1,num);
    bt=at;
    m=unique(randsor,'stable');
    for i=1:length(m)
    len=length(find(randsor==m(i)));
    j=m(i);
    if(j==num+1)
        atc=min(wk,0.2*(r-1)/r*sqrt(LCK/LC));
        btc=min(wk,0.2*(r-1)*sqrt(LCK/LC));
        corey=core+atc*(core-coreK);
        corez=core+btc*(core-coreK);
        coreK=core;
        [V,LC,vart,Vx]=IBPGgradcore(corey,corez,var,ngmar,r,num);
        core=PROX(coreze,V,coreaa);
        tao=1/(r*LC);
        for k=1:len-1
            corey=tensor(core+btc*(core-coreK));
            corez=tensor(core+atc*(core-coreK));
            coreK=core;
            corez=ttm(corez,vart);
            U=corez-Vx;
            V=corey-tao*U;
            core=PROX(coreze,V,coreaa);
        end


    else
        at(j)=min(wk,0.2*(r-1)/r*sqrt(LK(j)/L(j)));
        bt(j)=min(wk,0.2*(r-1)*sqrt(LK(j)/L(j)));
        vv=var;
        varz=var;
        vv{j}=var{j}+at(j)*(var{j}-varK{j});
        varz{j}=var{j}+bt(j)*(var{j}-varK{j});
        varK{j}=var{j};
        [V,L(j),Xtemp,temp]=IBPGgrad(core,vv,varz,ngmar,j,num,r);
        var{j}=PROX(varze{j},V,aa(j));
        tao=1/(r*L(j));    
        for k=1:len-1
            vv{j}=var{j}+at(j)*(var{j}-varK{j});
            varz{j}=var{j}+bt(j)*(var{j}-varK{j});
            varK{j}=var{j};
            mar=varz{j}*temp-Xtemp;
            V=vv{j}-tao*mar;
            var{j}=PROX(varze{j},V,aa(j));
        end
    end
    end
core=tensor(core);
end


%% Matrix's gradient calculation function for IBPG
function [U,L,Xtemp,temp]=IBPGgrad(core,var,varz,ngmar,n,num,r)
   core=tensor(core);
   index=1:num;
   index(n)=[];
   coreg=ttm(core,var,index);
   tempB=double(tenmat(coreg,n));
   temp=tempB*tempB';
   Xn=double(tenmat(ngmar,n));
   L=norm(temp,'fro');
   tao=1/(r*L);
   Xtemp=Xn*tempB';
   mar=varz{n}*temp-Xtemp;
   U=var{n}-tao*mar;
end

%% Core's gradient calculation function for IBPG
function [V,LC,vart,Vx]=IBPGgradcore(corey,corez,var,ngmar,r,num)
corez=tensor(corez);
corey=tensor(corey);
Vc=corez;
Vx=ngmar;
temp=1;
for i=1:num
    vart{i}=var{i}'*var{i};
    Vc=ttm(Vc,vart{i},i);
    Vx=ttm(Vx,var{i}',i);
    temp=temp*norm(vart{i},'fro');
end
LC=temp;
U=Vc-Vx;
tao=1/(r*temp);
V=corey-tao*U;
end

