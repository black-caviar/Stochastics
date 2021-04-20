clc
clear variables
close all

load('Iris.mat')

% So I assume that there are 3 normally distributed 

% Kind of elegant way to split but does not shuffle 
% Shuffle really doesn't matter 
split = false(1,length(features)); 
split(randperm(length(features), length(features)/2)) = 1;
train = features(split,:); 
val = features(~split,:);

mu = zeros(3,4);
Sig = zeros(4,4,3);
t_labels = labels(split);
for i = 1:3
    X_i = train(t_labels==i,:);
    mu(i,:) = mean(X_i);
    Sig(:,:,i) = cov(X_i);
end

% move this out to a function
prb = zeros(3, length(train));
for i = 1:3
    prb(i,:) = mvnpdf(train, mu(i,:), Sig(:,:,i));
end

[~,train_test] = max(prb)
train_test == t_labels'

%% Lets test classifier 
prb = zeros(3, length(val));
for i = 1:3
    prb(i,:) = mvnpdf(val, mu(i,:), Sig(:,:,i));
end

[~,val_test] = max(prb)
v_labels = labels(~split)';
val_test == v_labels 
% it should majority correct 

%% Confusing Matrix 

conf = zeros(3,3);
for i = 1:3
    conf(i,1) = sum((val_test == i) & (v_labels == 1));
    conf(i,2) = sum((val_test == i) & (v_labels == 2));
    conf(i,3) = sum((val_test == i) & (v_labels == 3));
end
conf

count = [sum(v_labels==1), sum(v_labels==2), sum(v_labels==3)];
%array2table(count, 'VariableNames', {'1, 2, 3'})
% Fuck tables 
