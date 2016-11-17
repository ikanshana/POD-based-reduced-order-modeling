%Modes refer to the POD modes matrix, number refers to number of the POD
%modes used, u is the data corresponding to the coefficients
function [a] = initialcondition(Modes,number,u)

a = zeros(number,1);


for i=1:number
       a(i,1) = u'*Modes(:,i);
end














