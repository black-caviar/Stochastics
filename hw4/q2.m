clc
clear variables
close all

load('Iris.mat')

% So I assume that there are 3 normally distributed 

% Kind of elegant way to split but does not shuffle 
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

prb = zeros(3, length(train));
for i = 1:3
    prb(i,:) = mvnpdf(train, mu(i,:), Sig(:,:,i));
end
