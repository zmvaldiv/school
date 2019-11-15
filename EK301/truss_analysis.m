%% Design Trust Analysis Script
% This script anal
%load inputs
load('TrussDesign1_ZeniaBrandonJerryEric_A1.mat');

%% Equilibruim equations
% use lin alg. A*T=L, A is coeff, T is var, L is result
%A: rows = 2j, columns = m+3 where last 3 are the Sx and Sy matrix
c = C;
%changes the value of the first 1 to -1, needed to find difference 
for i = 1:m
    idx = find(c(:,i),1,'first');
    c(idx,i) = -1;
end
 
%finds the difference between points
xp = X*c;
yp = Y*c;
xdiff = repmat(xp,j,1);
ydiff = repmat(yp,j,1);
 
%divides the difference by the distance to find the x and y components
distance = (xdiff.^2 + ydiff.^2).^(1/2);
xcomp = c.*xdiff./distance;


ycomp = c.*ydiff./distance;

%forms the A matrix where the first half of rows are the x component and
%the y component is the second half; last three columns are the Sx and Sy
%matrices
A = [xcomp Sx; ycomp Sy];


% use lin alg. T = (A^-1)(L)
T = A\L; %m+3 rows

for i = 1:length(T)
    if abs(T(i)) < 0.0001
        T(i) = 0;
    end
end

%% Additional calculations
fitStraw = 1334.8; %N/L^2

cost = 10*j + 100*sum(distance(1,:)); % cost of truss
mforce = abs(T(1:(length(T)-3))); %members force value
tORc = zeros(size(T(1:(length(T)-3))));
for i = 1:m
    if (T(i) > 0)
        tORc(i)= 'T';   %members in tension
    elseif(T(i)<0)
        tORc(i)= 'C';   %members in compression
    else
       tORc(i)= ' ';
    end
end

Sx1 = T(m+1);
Sy1 = T(m+2);
Sy2 = T(m+3);

 
%determines the maximum load the truss can handle before buckle and print
%the maximum load to cost ratio.
compF = T(1:(length(T)-3));
compF(compF>0) = 0;
compF = abs(compF)';
for i = 1:m
    compF(i) = compF(i)./(fitStraw/(100*distance(1,i)^2));
end
maxLoad = abs(sum(L))*(1/max(compF));

%% Results
%prints out the results

fprintf('EK301, Section A1, Group: Zenia V,Brandon V, Jerry N, Eric R,');
fprintf( ' 11/15/2019. ');
fprintf('Load: %d N \n',loadval);
fprintf('Member forces in Newtons \n')
for i = 1:m
    fprintf('m%d: %.3f (%c) \n',i,mforce(i),tORc(i));
end

fprintf('Reaction forces in Newtons: \n');
fprintf('Sx1: %.2f \nSy1: %.2f \nSy2: %.2f \n', Sx1, Sy1, Sy2);

fprintf('Cost of truss: $%.2f \n',cost);

fprintf('Theoretical max load/cost ratio in N/$: %.4f \n',maxLoad/cost);

