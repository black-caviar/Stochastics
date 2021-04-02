%% Change Point Estimation 
% I-An Huang 
clearvars
close all
%%
N = 100;

T = table('Size', [27 6], 'VariableTypes', ....
    {'double', 'double', 'double', 'double', 'double', 'double'}, ...
    'VariableNames', {'l1','l2','n','l1_hat','l2_hat','n_hat'});
row = 1;

% for different values of l1, l2, n
for l1=10:20:50
    for l2=20:20:60
        for n=[25 50 75]
            % generate observations
            X = [poissrnd(l1, 1, n), poissrnd(l2, 1, N-n)];
            % compute max-likelihood estimates
            [l1_hat, l2_hat, n_hat] = ML_estimator(X);
            % save results
            T(row,:) = {l1 l2 n l1_hat l2_hat n_hat};
            row = row + 1;
        end
    end
end

disp(T)

% max-likelihood estimator of change-point model
% X: 1 by N array of observations
% l1_hat, l2_hat, n_hat: scalar estimates of change-point model
function [l1_hat, l2_hat, n_hat] = ML_estimator(X)

N = length(X);

% max-likelihood estimators of l1 and l2
l1_est = @(X, n) mean(X(1:n));
l2_est = @(X, n) mean(X(n+1:end));

% log of the likelihood function
loglikelihood = @(X, n) -n*l1_est(X, n) - (N - n)*l2_est(X, n) ...
    + log(l1_est(X, n))*sum(X(1:n)) + log(l2_est(X, n))*sum(X(n+1:N)) ...
    - sum(log(factorial(X(1:n)))) - sum(log(factorial(X(n+1:N))));

% find max of log likelihoods
n_hat = 1;
loss = loglikelihood(X, n_hat);
for n=2:99
    if loglikelihood(X, n) > loss
        n_hat = n;
        loss = loglikelihood(X, n);
    end
end

l1_hat = l1_est(X, n_hat);
l2_hat = l2_est(X, n_hat);

end

%%
% With a reasonable difference between l1 and l2, 
% estimation works reasonably well.