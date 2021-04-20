%% Part 2, Iris Classification 
% Dan Brody, I-An Huang, Nikita Teplitskiy
%%
clc
clear variables
close all

load('Iris.mat')
%% Model class distributions 
% Assume there are 3 distinct normal distributions across 4 dimensions

split = false(1,length(features)); % generate data split 
split(randperm(length(features), length(features)/2)) = 1;
train = features(split,:); % training set
t_labels = labels(split)'; % training labels 

mu = zeros(3,4); % mean vector
Sig = zeros(4,4,3); % covariance matrix 
for i = 1:3
    X_i = train(t_labels==i,:); % extract examples of class i 
    mu(i,:) = mean(X_i);
    Sig(:,:,i) = cov(X_i);
end

train_pred = predict(train, mu, Sig); % predict classes 

train_error = 1-(sum(train_pred == t_labels)/length(train_pred));
fprintf("Training error: %f\n", train_error); 
% Why doesn't this print get published correctly?
%% Test classifier 
val = features(~split,:); % validation set 
v_labels = labels(~split)'; % validation labels
val_pred = predict(val, mu, Sig); % predict validation set 

val_error = 1-(sum(val_pred == v_labels )/length(val_pred));
fprintf("Validation error: %f\n", val_error);

%% Confusion Matrix 
% Generate confusion matrix to show success and failure conditions 
conf = zeros(3,3);
for i = 1:3
    % check classification 
    conf(i,1) = sum((val_pred == i) & (v_labels == 1));
    conf(i,2) = sum((val_pred == i) & (v_labels == 2));
    conf(i,3) = sum((val_pred == i) & (v_labels == 3));
end

fprintf('CONFUSION MATRIX')
array2table(conf, 'VariableNames', {'1','2','3'}, 'RowNames', {'1','2','3'})

%%
function class = predict(data, mu, Sig)
    prb = zeros(3, length(data));
    for i = 1:3
        prb(i,:) = mvnpdf(data, mu(i,:), Sig(:,:,i));
    end
    [~,class] = max(prb);
end