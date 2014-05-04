function writefile(L,T,datafile,cost,maxload,maxloadfactor,strawlength,strength,header)
         
[dummyvar name ext]=fileparts(datafile);

fid=fopen([name '_output' ext],'w');

%write header
for i=1:length(header)
    fprintf(fid,'%s\n',header{i});
end

%write date
dates=clock;
fprintf(fid,'%%DATE: %d/%d/%d\n',dates(2),dates(3),dates(1));

%write load
fprintf(fid,'Load: %.0f N\n',max(L));

%write member forces
fprintf(fid,'Member forces in Newtons:\n');
for i=1:length(T)-3
    if T(i)<0
        fprintf(fid,'m%d: %.3f (T)\n',i,-T(i));
    else
        fprintf(fid,'m%d: %.3f (C)\n',i,T(i));
    end
end

%write reaction forces
fprintf(fid,'Reaction forces in Newtons\n');
fprintf(fid,'Sx1: %.3f\n',T(end-2));
fprintf(fid,'Sy1: %.3f\n',-T(end-1));
fprintf(fid,'Sy2: %.3f\n',-T(end));

%write lengths
fprintf(fid,'Member Lengths\n');
for i=1:length(T)-3
    fprintf(fid,'m%d: %.3f cm\n',i,strawlength(i));
end
fprintf(fid,'Buckling Strengths\n');
%write buckling strengths
for i=1:length(strawlength)
    fprintf(fid,'m%d: %.3f N\n',i,strength(1)*strawlength(i)^-strength(2));
end


%Write max load info
fprintf(fid,'Maximal theoretical load: %.3f N\n',maxload);

criticalmembers=find(maxloadfactor>0.99999);
for i=1:length(criticalmembers)
    fprintf(fid,'Critical member %d: %d\n',i,criticalmembers(i));
    fprintf(fid,'Length of critical member %d: %.3f cm\n',i,strawlength(criticalmembers(i)) );
    fprintf(fid,'Buckling strength of critical member %d: %.3f N\n',i,strength(1)*strawlength(criticalmembers(i))^(-strength(2)));
end

%write cost and cost ratio
fprintf(fid,'Cost of truss: $%.2f\n',cost);
fprintf(fid,'Theoretical max load/cost ratio in N/$: %.4f',maxload/cost);
fclose(fid);