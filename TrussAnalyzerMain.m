%Truss analyzer
%Niklas Kunkel

%Prompt for data file to load
datafile=input('Load file: ','s');

%Straw strength model
strength=[322.7 1.375]; %strength [f a] represents strength equation of fL^-a
%l must be in CM

%------------------------------------------------------------
%Read data file

[C, Sx, Sy, X, Y, L, header]=readfile(datafile);

[j m]=size(C);

L=L';

%-------------------------------------------------------------

%ANALYSIS

length=calclength(C,X,Y,m);

T=calctensions(C,X,Y,Sx,Sy,L,j,m);

%------------------------------------------------------------

%Make a pretty drawing

load('colormap.mat')
[dummyvar filetitle ]=fileparts(datafile);
filetitle=upper(filetitle);
h=figure;
set(h,'name',filetitle)
tstr=sprintf('%s at %.1f N',filetitle,max(L));
title(tstr,'fontweight','bold')
axis equal

loadfactor=calcloadfac(T,m,strength,length);

drawbridge(C,X,Y,loadfactor,m,mycmap)

%-----------------------------------------------
%Calculate how many moneys
cost=sum(length)+10*j;
fprintf('This bridge will cost %.2f dollars.\n',cost)

%-------------------------------------------------
%calculate max load

multiplier=1/max(loadfactor);
maxload=max(L*multiplier);
Tmax=calctensions(C,X,Y,Sx,Sy,L*multiplier,j,m);
maxloadfactor=calcloadfac(Tmax,m,strength,length);

fprintf('The max load that this bridge can support is %.1f N.\n',maxload)

fprintf('Max load/cost ratio: %.4f\n\n',maxload/cost)

%draw bridge at max load
h=figure;
set(h,'name',[filetitle ' at max load'])
tstr=sprintf('%s at max load (%.1f N)',filetitle,maxload);
title(tstr,'fontweight','bold')
axis equal
drawbridge(C,X,Y,maxloadfactor,m,mycmap)

clear h dummyvar tst

%-------------------------------------------------
%Write file

writefile(L,T,datafile,cost,maxload, maxloadfactor, length, strength, header)

%-------------------------------------------------
%warn about lengths
if max(length)>15
    fprintf('Warning: following members are over 15 cm:')
    disp(find(length>15))
end
if min(length)<8
    fprintf('Warning: following members are under 8 cm:')
    disp(find(length<8)) 
end
if min(length)>=8 && max(length)<=15
    disp('All members respect size limits')
    fprintf('\n')
end
