%% Maximum likelihood estimation
%% Part 1
% Part 1: Generate random draws from both of the exponential and Rayleigh 
% random variables. You can use the EXPRND and RAYRND functions in MATLAB 
% for this. Implement your ML estimators in MATLAB and plot the MSE with 
% respect to # of observations. On separate plots, plot the bias and the 
% variance of your estimators, with respect to the # of observations. Do 
% this for a couple of values of l.
clearvars
close all
mse = @(x1,x2) (x1-x2).^2;
M = 1e4;
N = 5;
%% For Exponential


l = 4;
mse_exp = zeros(1,N);
for i = 1:N
    X_exp = exprnd(1/l, M, i); % What should mu be?
    l_hat = i/mean(sum(X_exp, 2));
    mse_exp(i) = l_hat;
    %mse_ray(i) = mmse(sqrt(s_hat), B);
end
mse_exp
plot(1:N,mse_exp)

%% For Rayleight 
X_exp = exprnd(1, 1, M); % What should mu be?

B = 2;
mse_ray = zeros(1,N);
for i = 1:N
    X_ray = raylrnd(B, M, i); % What should B be?
    s_hat = mean(sum(X_ray.^2, 2))/(2*i);
    mse_ray(i) = sqrt(s_hat);
    %mse_ray(i) = mmse(sqrt(s_hat), B);
end
mse_ray
plot(1:N,mse_ray)

