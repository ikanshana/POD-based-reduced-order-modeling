function [dat]=tecplotread(filename,NV,filefolder)

%%
%prepared by  C Laxman DORA 
%IIT Kanpur
%Reading dantec files

%%
%% NV=8; %% no of variables




% open Tecplot file and load
cd (filefolder)
fid = fopen(filename,'r');
if (fid<=0), error([mfilename ':io'],'Failed to load %s',filename); end;
dat.source = filename;

%% removing header line
%TITLE = "title"
for i=1:(NV+1)
ll=fgetl(fid);
end
%% variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
  for i=1:NV
    var{i}=['V',num2str(i)];
  end


%% Get no of variables and assign names

dat.vars=var;


%% reading the data 

count = 0;
%while ischar(ll)
%Dim = sscanf(ll, 'ZONE T="DynamicStudio Data" ,I=%d, J=%d,F=POINT')
ll = fgetl(fid); %%% two more headers
while ischar(ll)


ll = fgetl(fid);
ll = fgetl(fid);

Dim = sscanf(ll, ' I=%d, J=%d, K=1, ZONETYPE=Ordered')%%tecplot
ll = fgetl(fid);%%% two more headers
ll = fgetl(fid);
count=count+1;

%%
 nx = Dim(1);
 ny = Dim(2);
  %zone = ['zone',num2str(count)];
  
%   count = count + 1;  

   dat.zone{count}.I=nx;
   dat.zone{count}.J=ny;
     % read data 
      tmp=fscanf(fid,repmat('%f',[1,NV]),[NV,inf]);
      tmp=tmp';
    for iv = 1:length(var)
     % tmp  = fscanf(fid,'%f',nx*ny);   
      dat.zone{count}.(var{iv}) = tmp(:,iv);     
    end;
    ll = fgetl(fid);  
end
   fclose(fid)
end

% end

