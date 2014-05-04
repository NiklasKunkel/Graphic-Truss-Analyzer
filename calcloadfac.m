function loadfactor=calcloadfac(T,m,strength,length)

for i=1:m
         
    %calculate what percentage of its max load it is carrying, if it is in
    %compression
    if T(i)>0
        loadfactor(i)=T(i) / ( strength(1) * length(i)^(-strength(2)) );
    else
        loadfactor(i)=T(i)/20;
    end
    
end