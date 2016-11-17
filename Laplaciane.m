function [uxx1,uyy1,vxx1,vyy1] = Laplaciane(u1,v1,dx,dy,N,Nx,Ny,f1,f2)
if f1==1
R1 = Nx*Ny;
u_temp = reshape(u1,Nx,Ny,N);
v_temp = reshape(v1,Nx,Ny,N);
u = zeros(Ny,Nx,N);
v = u;
for i=1:N
    u(:,:,i) = u_temp(:,:,i)';
    v(:,:,i) = v_temp(:,:,i)';
end
else 
    
   u = u1;
   v = v1;
end



% Num = size(u);
% N = Num(1,3);
uxx = zeros(Ny,Nx,N);
uyy = uxx;
vxx = uxx;
vyy = uxx;
Nx1 = Nx-1;
Ny1 = Ny-1;

for i=1:Nx
   
    if i==1
       uxx(:,i,:) = (u(:,i,:)-2*u(:,i+1,:)+u(:,i+2,:))/(dx*dx);
       vxx(:,i,:) = (v(:,i,:)-2*v(:,i+1,:)+v(:,i+2,:))/(dx*dx);
       
   elseif i==2
       uxx(:,i,:) = (u(:,i+1,:)-2*u(:,i,:)+ u(:,i-1,:))/(dx*dx);
       vxx(:,i,:) = (v(:,i+1,:)-2*v(:,i,:)+ v(:,i-1,:))/(dx*dx);
       
    elseif i==Nx1
        uxx(:,i,:) = (u(:,i+1,:) - 2*u(:,i,:)+u(:,i-1,:))/(dx*dx);
        vxx(:,i,:) = (v(:,i+1,:) - 2*v(:,i,:) + v(:,i-1,:))/(dx*dx);
       
    elseif i==Nx
        uxx(:,i,:) = (u(:,i,:)-2*u(:,i-1,:)+u(:,i-2,:))/(dx*dx);
        vxx(:,i,:) = (v(:,i,:)-2*v(:,i-1,:)+v(:,i-2,:))/(dx*dx);
        
    else 
        uxx(:,i,:) = (-u(:,i+2,:) - u(:,i-2,:) + 16*u(:,i+1,:) +  16*u(:,i-1,:) - 30*u(:,i,:))/(12*dx*dx);
        vxx(:,i,:) = (-v(:,i+2,:) - v(:,i-2,:) + 16*v(:,i+1,:) +  16*v(:,i-1,:) - 30*v(:,i,:))/(12*dx*dx);      
 

    end
end


for i=1:Ny
   
   if i==1
       uyy(i,:,:) = (u(i,:,:)-2*u(i+1,:,:)+ u(i+2,:,:))/(dy*dy);
       vyy(i,:,:) = (v(i,:,:)-2*v(i+1,:,:)+ v(i+2,:,:))/(dy*dy);
       
   elseif i==2
       uyy(i,:,:) = (u(i+1,:,:)-2*u(i,:,:)+ u(i-1,:,:))/(dy*dy);
       vyy(i,:,:) = (v(i+1,:,:)-2*v(i,:,:)+ v(i-1,:,:))/(dy*dy);
       
    elseif i==Ny1
        uyy(i,:,:) = (u(i+1,:,:) - 2*u(i,:,:)+ u(i-1,:,:))/(dy*dy);
        vyy(i,:,:) = (v(i+1,:,:) - 2*v(i,:,:) + v(i-1,:,:))/(dy*dy);
       
    elseif i==Ny
        uyy(i,:,:) = (u(i,:,:)- 2*u(i-1,:,:)+ u(i-2,:,:))/(dy*dy);
        vyy(i,:,:) = (v(i,:,:)- 2*v(i-1,:,:)+ v(i-2,:,:))/(dy*dy);
        
    else 
        uyy(i,:,:) = (-u(i+2,:,:) - u(i-2,:,:) + 16*u(i+1,:,:) +  16*u(i-1,:,:) - 30*u(i,:,:))/(12*dy*dy);
        vyy(i,:,:) = (-v(i+2,:,:) - v(i-2,:,:) + 16*v(i+1,:,:) +  16*v(i-1,:,:) - 30*v(i,:,:))/(12*dy*dy);      
 

    end
end

if f2==1
    
    uxx_temp = zeros(Nx,Ny,N);
    uyy_temp = uxx_temp;
    vxx_temp = uxx_temp;
    vyy_temp = uxx_temp;

    for i=1:N
    uxx_temp(:,:,i) = uxx(:,:,i)';
    uyy_temp(:,:,i) = uyy(:,:,i)';
    vxx_temp(:,:,i) = vxx(:,:,i)';
    vyy_temp(:,:,i) = vyy(:,:,i)';
    end
    uxx1 = reshape(uxx_temp,R1,N);
    uyy1 = reshape(uyy_temp,R1,N);
    vxx1 = reshape(vxx_temp,R1,N);
    vyy1 = reshape(vyy_temp,R1,N);
    
else
    uxx1 = uxx;
    uyy1 = uyy;
    vxx1 = vxx;
    vyy1 = vyy;
    
end
end