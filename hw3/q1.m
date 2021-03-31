%% Part 1
% Generate random draws from both of the exponential and 
% Rayleigh random variables. You can use the EXPRND and RAYRND functions 
% in MATLAB for this. Implement your ML estimators in MATLAB and plot 
% the MSE with respect to # of observations. On separate plots, plot 
% the bias and the variance of your estimators, with respect to the # of 
% observations. Do this for a couple of values of lambda.
clc
clear all
close all

M = 1e4;

% ML estimator for exponential random variable
% N: number of observations
% X: N by M array of observations
exp_estimator = @(N, X) N./sum(X, 1);

% ML estimator for Rayleigh random variable
% N: number of observations
% X: N by M array of observations
ray_estimator = @(N, X) sqrt(sum(X.^2, 1)./(2*N));

exp_MSE = zeros(10, 4);
ray_MSE = zeros(10, 4);
exp_bias = zeros(10, 4);
ray_bias = zeros(10, 4);
exp_var = zeros(10, 4);
ray_var = zeros(10, 4);
for lambda=1:4
    alpha = lambda;
    for N=1:10
        X = exprnd(1/lambda, N, M);
        lambda_hat = exp_estimator(N, X);
        exp_MSE(N, lambda) = mean((lambda - lambda_hat).^2);
        exp_bias(N, lambda) = mean(lambda - lambda_hat);
        exp_var(N, lambda) = var(lambda_hat);
        
        X = raylrnd(alpha, N, M);
        alpha_hat = ray_estimator(N, X);
        ray_MSE(N, alpha) = mean((alpha - alpha_hat).^2);
        ray_bias(N, alpha) = mean(alpha - alpha_hat);
        ray_var(N, alpha) = var(lambda_hat);
    end
end

% MSE of first 2 observations too large

subplot(3, 2, 1)
plot(3:10, exp_MSE(3:10,:))
ylabel('Mean Squared Error')
xlabel('# of Observations')
title('MLE of exponential random variable');
legend({'$\lambda = 1$','$\lambda = 2$', ...
    '$\lambda = 3$','$\lambda = 4$'}, ...
    'Interpreter','latex');

subplot(3, 2, 2)
plot(3:10, ray_MSE(3:10,:))
ylabel('Mean Squared Error')
xlabel('# of Observations')
title('MLE of Rayleigh random variable');
legend({'$\alpha = 1$','$\alpha = 2$', ...
    '$\alpha = 3$','$\alpha = 4$'}, ...
    'Interpreter','latex');

subplot(3, 2, 3)
plot(3:10, exp_bias(3:10,:))
ylabel('Bias')
xlabel('# of Observations')
title('MLE of exponential random variable');
legend({'$\lambda = 1$','$\lambda = 2$', ...
    '$\lambda = 3$','$\lambda = 4$'}, ...
    'Interpreter','latex');

subplot(3, 2, 4)
plot(3:10, ray_bias(3:10,:))
ylabel('Bias')
xlabel('# of Observations')
title('MLE of Rayleigh random variable');
legend({'$\alpha = 1$','$\alpha = 2$', ...
    '$\alpha = 3$','$\alpha = 4$'}, ...
    'Interpreter','latex');

subplot(3, 2, 5)
plot(3:10, exp_var(3:10,:))
ylabel('Variance')
xlabel('# of Observations')
title('MLE of exponential random variable');
legend({'$\lambda = 1$','$\lambda = 2$', ...
    '$\lambda = 3$','$\lambda = 4$'}, ...
    'Interpreter','latex');

subplot(3, 2, 6)
plot(3:10, ray_var(3:10,:))
ylabel('Variance')
xlabel('# of Observations')
title('MLE of Rayleigh random variable');
legend({'$\alpha = 1$','$\alpha = 2$', ...
    '$\alpha = 3$','$\alpha = 4$'}, ...
    'Interpreter','latex');