
 
Nx = input('Number of grid points in x-direction = ');
Ny = input('Number of grid points in y-direction = ');
Sn = input('Number of snapshots = ');
dx = input('cell size in x-direction = ');
dy = input('cell size in y-direction = ');
n = input('Number of POD modes to be calculated = ');
nu = input('kinematic viscosity = ');
%  
R1 = Nx*Ny;
%  
% folder analysis is the folder where fluctuating and mean velocity data is stored
analysis_folder = uigetdir('','Select folder containing velocity data');
 
% % function 'tecplotread' removes the string from the fluctuating velocity data and store it in dat variable.
[dat] = tecplotread('uniform_fluctuations.dat',2,analysis_folder);
% 
%  
cd 'E:\Work\Matlab_codes'       % since directory is changed by tecplotread it is again changed to matlab_codes folder.
%  
% % loading average variable
V_av = load([analysis_folder,'\','uniform_mean.dat']); Ua = V_av(:,1); Va = V_av(:,2);

% calculation of POD modes, U is the matrix containing the snapshots as columns. Value is a diagonal matrix with eigenvalues.
[MODES,U,C1,Value] = POD(dat,n,Sn,Nx,Ny);

% umodes and vmodes are streamwise and normal component of the modes.
% pod_MPC to be used when inner product is based on mid-point curvature rule as in Lutchenberg et al.
%%[umodes,vmodes,Val] = pod_MPC(dat,dx,dy,nx,ny,sn,n);
umodes = MODES(1:R1,:);vmodes = MODES(R1+1:2*R1,:);

% the loop writes the system of ODE using i modes (i is the index of the loop).
for i=2:10
nmodes = i; %nmodes is the number of modes used in the system. 
  
Icondition =10; t2 = .3;tspan = [0:.0007:t2];  %Icondition is the initial condition, t2 is the time over which you want to solve the system, tspan
% defines the time steps of the solution.


% calculation of eddy viscosity term for the system of ODE.
D{i} = Cazemeir_eddy(MODES,Ua,Va,U,Value,nmodes,dx,dy,Sn,Nx,Ny);


odesystem_withouteddy = ['test_',num2str(nmodes)];      % filename where system of ode without any eddy viscosity model is written.
odesystem_witheddy = ['teste_',num2str(nmodes)];        % filename where system of ode using eddy viscosity model is written.

% function 'model_equations' create the models either with or without eddy viscosity model in the given filename.
model_equations(umodes(:,1:nmodes),vmodes(:,1:nmodes),Ua,Va,nmodes,Nx,Ny,dx,dy,Sn,nu,Value,zeros(nmodes,nmodes),odesystem_withouteddy,analysis_folder);
model_equations(umodes(:,1:nmodes),vmodes(:,1:nmodes),Ua,Va,nmodes,Nx,Ny,dx,dy,Sn,nu,Value,D{i},odesystem_witheddy,analysis_folder);


I = U(:,Icondition);       % I is a column vector of fluctuating velocity at the given initial condition.

[y0] = initialcondition(MODES,nmodes,I);       % y0 is the initial values of the POD coefficients used in the model.
cd(analysis_folder);       % changing current folder to analysis folder because equation file used in the next two line is saved there.
[T{i},Y{i}] = ode45(odesystem_withouteddy,tspan,y0);       %solution to the model without eddy viscosity model
[T_eddy{i},Y_eddy{i}] = ode45(odesystem_witheddy,tspan,y0);        %solution to the model with eddy viscosity model    
 
end



cd 'E:\Work\Matlab_codes'       % current folder changed to matlab code folder
Y_e = zeros(nmodes,Sn-Icondition+1);       % Experimental POD mode coefficients for comparison
T_e = [0:.0027:t2];     %     
Np = size(T_e,2);
t = Icondition;
for i=1:Np
Y_e(:,i) = initialcondition(MODES,nmodes,U(:,t));
t = t+1;
end
cd(analysis_folder);
save('workspace');
cd 'E:\Work\Matlab_codes'

% % PLOTS is just to make the relevant plots from the output coefficients
% PLOTS(T_e,T,T_eddy,Y_e,Y,Y_eddy,Value,Np,analysis_folder);













