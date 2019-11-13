%% Design Trust Analysis Script
% This script anal
%load inputs
load(filename);

%% Equilibruim equations
% A X T = L ; use lin alg. A*T=L, A is coeff, T is var, L is result
A = []; % rows = 2j, columns = m+3 where last 3 are the Sx and Sy matrix
T = []'; %m+3 rows

% Use T = (A^-1)(L)

%% Buckling Member
% Use SR = Finternal/Fbuckling
% F_failure = 1 N load / SRmax

%% Additional calculations


%% Results
%prints out the results
load = 1;
fprintf('EK301, Section A1, Group: Zenia V,Brandon V, Jerry N, Eric R,');
fprintf( ' 2/15/20xx.');
fprintf('Load: %d N /n',load);
fprintf('Member forces in Newtons /n')
for i = 1:m
    fprintf('m%d: %.3f (%c) /n',i,mforce,direction);
end

fprintf('Reaction forces in Newtons: /n');
fprintf('Sx1: %.2f /n Sy1: %.2f /n Sy2: %.2f /n', Sx1, Sy1, Sy2);

fprintf('Cost of truss: $%d',cost);

fprintf('Theoretical max load/cost ratio in N/$: %.4f',maxlcrat);

