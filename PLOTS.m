function PLOTS(T_e,T,T_eddy,Y_e,Y,Y_eddy,Value,Np,funfolder)
plotmode = 1;
h = figure;
cd(funfolder);


%Eigenvalue plot
plot(cumsum(flipud(diag(Value)/sum(diag(Value)))));
axis([1,10,.4,1])
saveas(gcf,'eigenvalueplot');


%Coefficients plot
for i=1:6
 subplot(3,2,i)
 plot(T_e,Y_e(plotmode,1:Np));
hold on
 plot(T{i+1},Y{i+1}(:,plotmode));
 plot(T_eddy{i+1},Y_eddy{i+1}(:,plotmode),'r');
 title([num2str(i+1),'mode model']);  ylabel(['a',num2str(plotmode)]);
end
hold off 
saveas(gcf,['a',num2str(plotmode)]);

plotmode = 2;
h(plotmode) = figure;

for i=1:6
 subplot(3,2,i)
 plot(T_e,Y_e(plotmode,1:Np));
 hold on
  plot(T{i+1},Y{i+1}(:,plotmode))
 plot(T_eddy{i+1},Y_eddy{i+1}(:,plotmode),'r');
 title([num2str(i+1),'mode model']);  ylabel(['a',num2str(plotmode)]);
end
hold off 
saveas(gcf,['a',num2str(plotmode)]);

plotmode = 3;
h(plotmode) = figure;

for i=2:6
 subplot(3,2,i)
 plot(T_e,Y_e(plotmode,1:Np));
hold on
  plot(T{i+1},Y{i+1}(:,plotmode));
 plot(T_eddy{i+1},Y_eddy{i+1}(:,plotmode),'r');
 title([num2str(i+1),'mode model']);  ylabel(['a',num2str(plotmode)]);
end
hold off
saveas(gcf,['a',num2str(plotmode)]);


plotmode = 4;
h(plotmode) = figure;

for i=3:6
 subplot(3,2,i);
hold on 
 plot(T_e,Y_e(plotmode,1:Np)); 
  plot(T{i+1},Y{i+1}(:,plotmode));
 plot(T_eddy{i+1},Y_eddy{i+1}(:,plotmode),'r');
 title([num2str(i+1),'mode model']);  ylabel(['a',num2str(plotmode)]);
end
hold off
saveas(gcf,['a',num2str(plotmode)]);

%frequeny plot
figure;
subplot(2,2,1);
plotmode = 1;
[p,f] = spectrum(Y_e(plotmode,:),256,200,256,365);plot(f,p(:,1),'m');title('experimental frequency specturem'); ylabel(['a',num2str(plotmode)]);xlim([0 100]);
for i=1:3
subplot(2,2,i+1);
[p,f] = spectrum(Y_eddy{i+1}(:,plotmode),1024,1000,1024,1428.6);plot(f,p(:,1));title([num2str(i+1),'mode model']); ylabel(['a',num2str(plotmode)]);xlim([0 100]);

end

 saveas(gcf,['a',num2str(plotmode),'frequency spectrum']);
 
figure;
subplot(2,2,1);
plotmode = 2;
[p,f] = spectrum(Y_e(plotmode,:),256,200,256,365);plot(f,p(:,1),'m');title('experimental frequency specturem'); ylabel(['a',num2str(plotmode)]);xlim([0 100]);
for i=1:3
subplot(2,2,i+1);
[p,f] = spectrum(Y_eddy{i+1}(:,plotmode),1024,1000,1024,1428.6);plot(f,p(:,1));title([num2str(i+1),'mode model']); ylabel(['a',num2str(plotmode)]);xlim([0 100]);

end

 saveas(gcf,['a',num2str(plotmode),'frequency spectrum']);
 
 
figure;
subplot(2,2,1);
plotmode = 3;
[p,f] = spectrum(Y_e(plotmode,:),256,200,256,365);plot(f,p(:,1),'m');title('experimental frequency specturem'); ylabel(['a',num2str(plotmode)]);xlim([0 100]);
for i=1:3
subplot(2,2,i+1);
[p,f] = spectrum(Y_eddy{i+2}(:,plotmode),1024,1000,1024,1428.6);plot(f,p(:,1));title([num2str(i+2),'mode model']); ylabel(['a',num2str(plotmode)]);xlim([0 100]);

end

 saveas(gcf,['a',num2str(plotmode),'frequency spectrum']);
 
 
figure;
subplot(2,2,1);
plotmode = 4;
[p,f] = spectrum(Y_e(plotmode,:),256,200,256,365);plot(f,p(:,1),'m');title('experimental frequency specturem'); ylabel(['a',num2str(plotmode)]);xlim([0 100]);
for i=1:3
subplot(2,2,i+1);
[p,f] = spectrum(Y_eddy{i+3}(:,plotmode),1024,1000,1024,1428.6);plot(f,p(:,1));title([num2str(i+3),'mode model']); ylabel(['a',num2str(plotmode)]);xlim([0 100]);

end

 saveas(gcf,['a',num2str(plotmode),'frequency spectrum']);

 cd E:\
end


