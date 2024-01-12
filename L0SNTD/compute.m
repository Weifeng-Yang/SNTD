%% Calculate the value of the objective function
function loss=compute(core,var,ngmar)
core=tensor(core);
S=ttm(core,var);

loss=norm(ngmar-S);




end

