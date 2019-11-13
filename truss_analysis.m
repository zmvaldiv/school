%% Design Trust Analysis Script
% define variables
j = 0; % number of joints 
m = 0; % number of members
C = zeros(j,m); %connection matrix where j is joint and m is member

%% Connection matrix for the support forces
Sx = zeros(j,3); %support along x axis
Sy = zeros(j,3); %support along y axis

%% 
