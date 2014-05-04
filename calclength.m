function length=calclength(C,X,Y,m)

length=zeros(1,m);
for i=1:m
    
    connections=find( C(:,i)==1 );
    
    length(i) = sqrt((X(connections(1))-X(connections(2)))^2 + (Y(connections(1))-Y(connections(2)))^2);
    
end