function [MODES,U,C1,Value] = POD(dat,n,Sn,Nx,Ny)

R1 = Nx*Ny;R2 = R1*2;
 
U = zeros(R2,Sn);
for i=1:Sn
U(1:R1,i) = dat.zone{1,i}.V1;
U(R1+1:R2,i) = dat.zone{1,i}.V2;
end

C1 = U'*U;
%m = zeros(R2,1);
%MODES = zeros(R2,n);
%size(C1)
[Vec,Value] = eig(C1);
%size(Vec)
m = zeros(R2,1);
for x=1:n
  m(:,1) = 0;
		for y=1:Sn
			m(:,1) = m(:,1) + Vec(y,((Sn+1)-x))*U(:,y); 
		end
  MODES(:,x) = m/norm(m);
 end


