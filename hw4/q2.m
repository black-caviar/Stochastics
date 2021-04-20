clc
clear variables
close all

load('Iris.mat')

split = false(1,length(features));
split(randperm(length(features), length(features)/2)) = 1;
train = features(split,:); 
val = features(~split,:);

mu = mean(train);
Sig = diag(var(train));