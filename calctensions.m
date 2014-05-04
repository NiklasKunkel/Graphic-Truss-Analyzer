function T=calctensions(C,X,Y,Sx,Sy,L,j,m)

Ax=zeros(j,m);
Ay=zeros(j,m);


for i = 1:m
    
    connections=find( C(:,i)==1 );
    
    Ax(connections(1),i) = (X(connections(2)) - X(connections(1))) / sqrt((X(connections(1))-X(connections(2)))^2 + (Y(connections(1))-Y(connections(2)))^2);
    Ax(connections(2),i) = (X(connections(1)) - X(connections(2))) / sqrt((X(connections(1))-X(connections(2)))^2 + (Y(connections(1))-Y(connections(2)))^2);
    
    Ay(connections(1),i) = (Y(connections(2)) - Y(connections(1))) / sqrt((X(connections(1))-X(connections(2)))^2 + (Y(connections(1))-Y(connections(2)))^2);
    Ay(connections(2),i) = (Y(connections(1)) - Y(connections(2))) / sqrt((X(connections(1))-X(connections(2)))^2 + (Y(connections(1))-Y(connections(2)))^2);
    
end

A=[Ax, Sx; Ay, Sy];

%SOLVE THAT BITCH
T = inv(A) * -L ;