%% Proximal projection function
function [x,IX]=PROX(x,U,a)
S=U(:);
[~,IX] = sort(S(:),'descend');
if(a>length(IX))
    a=length(IX);
end
x(IX(1:a))=U(IX(1:a));
x(x<0)=0;
end

