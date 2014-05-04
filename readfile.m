function [C, Sx, Sy, X, Y, L, header]=readfile(datafile)

fid=fopen(datafile);

C=[];
Sx=[];
Sy=[];
X=[];
Y=[];
L=[];
header={};

stage=1;

while ~feof(fid)
    
    %get line; ignore blank line
    aline=fgetl(fid);
    if isempty(aline)
        continue
    end
    
    switch stage
        
        case 1
            if strcmpi(aline(1),'c')
                [dummyvar aline]=strtok(aline,'[');
                aline=aline(2:end);
                C(end+1,:)=str2num(aline);
                stage=2;
            else
                header{end+1}=aline;
            end
            
        case 2
            [aline dummyvar]=strtok(aline,']');
            if strcmpi(aline(1:2),'sx')
                [dummyvar aline]=strtok(aline,'[');
                aline=aline(2:end);
                Sx(end+1,:)=str2num(aline);
                stage=3;
            else
                C(end+1,:)=str2num(aline);
            end
            
        case 3
            [aline ~]=strtok(aline,']');
            if strcmpi(aline(1:2),'sy')
                [dummyvar aline]=strtok(aline,'[');
                aline=aline(2:end);
                Sy(end+1,:)=str2num(aline);
                stage=4;
            else
                Sx(end+1,:)=str2num(aline);
            end
            
        case 4
            [aline dummyvar]=strtok(aline,']');
            if strcmpi(aline(1),'X')
                [dummyvar aline]=strtok(aline,'[');
                aline=aline(2:end);
                X=str2num(aline);
                stage=5;
            else
                Sy(end+1,:)=str2num(aline);
            end
            
        case 5
            eval(aline);
            
    end
    
end

fclose(fid);