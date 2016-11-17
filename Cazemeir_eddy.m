function [D] = Cazemeir_eddy(MODES,Ua,Va,U,Value,N,dx,dy,Sn,Nx,Ny)
R1 = Nx*Ny;

u = MODES(1:R1,1:N);
v = MODES((R1+1):2*R1,1:N);

[Ux,Uy,Vx,Vy] = Derivative(u,v,dx,dy,N,Nx,Ny,1,1);
[Uax,Uay,Vax,Vay] = Derivative(Ua,Va,dx,dy,1,Nx,Ny,1,1);
[Uxx,Uyy,Vxx,Vyy] = Laplaciane(u,v,dx,dy,N,Nx,Ny,1,1);

Val1 = diag(Value);
Val = flipud(Val1);
Val = Val/479;

A1 = zeros(N,1);
B2 = zeros(N,N);
D = zeros(N,1);
nu = .0000157;

a = zeros(N,Sn);
for i=1:Sn
a(:,i) = initialcondition(MODES,N,U(:,i));
end


for i=1:N
    %i
    A1(i)= -((u(:,i).*Uax + v(:,i).*Uay) + (Ua.*Ux(:,i) + Va.*Uy(:,i)) - (nu)*(Uxx(:,i) + Uyy(:,i)))'*u(:,i) - ((u(:,i).*Vax + v(:,i).*Vay)+(Ua.*Vx(:,i) + Va.*Vy(:,i))-(nu)*(Vxx(:,i) +Vyy(:,i)))'*v(:,i);
    D(i) = Val(i)*A1(i);
    l=1;
    for k1 = 1:N
        %k1
    for k2 = 1:N
        B2(i,l) = -((u(:,k1).*Ux(:,k2) + v(:,k1).*Uy(:,k2))'*u(:,i) + (u(:,k1).*Vx(:,k2) + v(:,k1).*Vy(:,k2))'*v(:,i));
        avg = 0;
        for j = 1:Sn
        
        avg = avg + a(i,j)*a(k1,j)*a(k2,j);
        end
        avg = avg/Sn;
        
        D(i) = D(i) + B2(i,l)*avg;
        l = l+1;
    end
    end
    
    D(i) = -(D(i)/Val(i));
end
D = diag(D);
end