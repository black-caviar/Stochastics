% X = event of a dice roll
% Y = event of generating an ability score
% Z = event of generating an ability score using the fun method
%% a

% dice roll uniform distribution
pmf_X = ones(6, 1).*1/6;

% each dice roll independent
joint_pmf_X = ones(6, 6, 6).*(1/6^3);

% generate all permutations
[X1, X2, X3] = ndgrid(1:6); 
Y = X1 + X2 + X3;

pmf_Y = zeros(18, 1);
for y=3:18
    pmf_Y(y) = sum(joint_pmf_X(Y == y));
end

p_1a = pmf_Y(18) 

%% b

% triple outer product
% not sure if there's a more elegant way of doing this
joint_pmf_Y = pmf_Y*pmf_Y';
joint_pmf_Y = reshape(joint_pmf_Y(:)*pmf_Y', 18, 18, 18);

% generate all permutations
[Y1, Y2, Y3] = ndgrid(1:18); 
Z = max(cat(4, Y1, Y2, Y3), [], 4);

pmf_Z = zeros(18, 1);
for z=3:18
    pmf_Z(z) = sum(joint_pmf_Y(Z == z));
end

p_1b = pmf_Z(18)

%% c

p_1c = pmf_Z(18)^6

%% d

p_1d = pmf_Z(9)^6

%% interesting stuff
% figure
% stem(pmf_X)
% figure
% stem(pmf_Y)
% figure
% stem(pmf_Z)