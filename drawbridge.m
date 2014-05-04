function drawbridge(C,X,Y,loadfactor,m,mycmap)

for i=1:m
    
    
    %make colorindex from load factor
    colorindex = round(32 + loadfactor(i)*32);
    
    %bounds
    if colorindex>64
        colorindex=64;
    elseif colorindex<1
        colorindex=1;
    end
    
    %if straw will fail, make it BOLD
    if colorindex==64
        w=4;
    else
        w=2;
    end
    
    %draw line
    connections=find( C(:,i)==1 );
    line([X(connections(1)),X(connections(2))], [Y(connections(1)),Y(connections(2))], 'LineWidth',w, 'Color',mycmap(colorindex,:))
    
end