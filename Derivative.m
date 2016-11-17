function [ux1,uy1,vx1,vy1] = Derivative(u1,v1,dx,dy,N,Nx,Ny,f1,f2)
%input f1 as 2 if uv are already in correct grid format is .input f2 as 2 if output is required in grid format
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

ux = zeros(Ny,Nx,N);
vx = ux;
uy = ux;
vy = ux;
Nx1 = Nx-1;
Ny1 = Ny-1;

for i=1:Nx
   
    if i==1
       ux(:,i,:) = (u(:,i+1,:)-u(:,i,:))/dx;
       vx(:,i,:) = (v(:,i+1,:)-v(:,i,:))/dx;
          
    elseif i==2
       ux(:,i,:) = (u(:,i+1,:) - u(:,i-1,:))/(2*dx);
       vx(:,i,:) = (v(:,i+1,:) - v(:,i-1,:))/(2*dx);
   
    elseif i==Nx1
        ux(:,i,:) = (u(:,i+1,:) - u(:,i-1,:))/(2*dx);
        vx(:,i,:) = (v(:,i+1,:) - v(:,i-1,:))/(2*dx);
        
    elseif i==Nx
        ux(:,i,:) = (u(:,i,:)-u(:,i-1,:))/dx;
        vx(:,i,:) = (v(:,i,:)-v(:,i-1,:))/dx;
        
    else 
        ux(:,i,:) = (-2*u(:,i+2,:) + 2*u(:,i-2,:) + 16*u(:,i+1,:) - 16*u(:,i-1,:))/(24*dx);
        vx(:,i,:) = (-2*v(:,i+2,:) + 2*v(:,i-2,:) + 16*v(:,i+1,:) - 16*v(:,i-1,:))/(24*dx);   
 

    end
end


for i=1:Ny
  
    if i==1
       uy(i,:,:) = -(u(i+1,:,:)-u(i,:,:))/dy;
       vy(i,:,:) = -(v(i+1,:,:)-v(i,:,:))/dy;
   
    elseif i==2
       uy(i,:,:) = -(u(i+1,:,:) - u(i-1,:,:))/(2*dy);
       vy(i,:,:) = -(v(i+1,:,:) - v(i-1,:,:))/(2*dy);
   
    elseif i==Ny1
        uy(i,:,:) = -(u(i+1,:,:) - u(i-1,:,:))/(2*dy);
        vy(i,:,:) = -(v(i+1,:,:) - v(i-1,:,:))/(2*dy);
       
    elseif i==Ny
        uy(i,:,:) = -(u(i,:,:)-u(i-1,:,:))/dy;
        vy(i,:,:) = -(v(i,:,:)-v(i-1,:,:))/dy;
        
    else 
        uy(i,:,:) = -(-2*u(i+2,:,:) + 2*u(i-2,:,:) + 16*u(i+1,:,:) - 16*u(i-1,:,:))/(24*dy);
        vy(i,:,:) = -(-2*v(i+2,:,:) + 2*v(i-2,:,:) + 16*v(i+1,:,:) - 16*v(i-1,:,:))/(24*dy);       
 

    end
end

    if f2==1
        ux_temp = zeros(Nx,Ny,N);
        uy_temp = ux_temp;
        vx_temp = ux_temp;
        vy_temp = ux_temp;

        for i=1:N
        ux_temp(:,:,i) = ux(:,:,i)';
        uy_temp(:,:,i) = uy(:,:,i)';
        vx_temp(:,:,i) = vx(:,:,i)';
        vy_temp(:,:,i) = vy(:,:,i)';
        end
        ux1 = reshape(ux_temp,R1,N);
        uy1 = reshape(uy_temp,R1,N);
        vx1 = reshape(vx_temp,R1,N);
        vy1 = reshape(vy_temp,R1,N);
    else
        ux1 = ux;
        uy1 = uy;
        vx1 = vx;
        vy1 = vy;
    end

end






