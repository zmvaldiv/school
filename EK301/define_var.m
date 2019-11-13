%% Define variables
% the following script defines the variables needed for truss_analysis.m 
% please input the necessary values

clear

j = 0; % number of joints 
m = 0; % number of members

C = zeros(j,m); %connection matrix where j is joint and m is member

Sx = zeros(j,3); %support along x axis
Sy = zeros(j,3); %support along y axis

X = []; %each j element corresponds to relevant location of j joint
Y = []; %each j element corresponds to relevant location of j joint

L = []'; %2j elements; first half is horz. load, second half is vert. load

%change design number for each new design
design_num = 'TrussDesignCheck';
filename = [design_num, '_ZeniaBrandonJerryEric_A1.mat'];
save(filename,'C','Sx','Sy','X','Y','L');

clear 



