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
N = 10;
%% For Exponential


l = 4;
mse_exp = zeros(2,N);
for i = 1:N
    X_exp = exprnd(1/l, M, i); % What should mu be?
    l_hat = ml_exp(X_exp);
    mse_exp(1,i) = mean(l_hat);
    mse_exp(2,i) = var(l_hat);
    %mse_ray(i) = mmse(sqrt(s_hat), B);
end
mse_exp(1,:)
%plot(1:N,mse(mse_exp, l))

%Bias = E(l) - l


%% For Rayleight 
X_exp = exprnd(1, 1, M); % What should mu be?

B = 2;
mse_ray = zeros(2,N);
for i = 1:N
    X_ray = raylrnd(B, M, i); % What should B be?
    %s_hat = mean(sum(X_ray.^2, 2)./(2*i));
    s_hat = ml_ray(X_ray);
    mse_ray(1,i) = mean(s_hat);
    mse_ray(2,i) = var(s_hat);
    %mse_ray(i) = mmse(sqrt(s_hat), B);
end
mse_ray
plot(1:N,mse_ray(1,:))

%% For Data
% refactor estimators into functions
close all
load('data.mat', '-mat')
histogram(data, 'Normalization','pdf') % This really looks like Rayleigh 
hold on
ray_pred = ml_ray(data);

ray = @(x,s) x./(s.^2) .* exp(-x.^2./(2*s^2))
x = linspace(min(data),max(data));
plot(x, ray(x,ray_pred))

exp_pred = ml_exp(data)
expo = @(x,l) l*exp(-l*x)
plot(x, expo(x, exp_pred))


function s_hat = ml_ray(x)
    dim = size(x);
    s_hat = sqrt(sum(x.^2, 2)./(2*dim(2)));
end

function l_hat = ml_exp(x)
    dim = size(x);
    l_hat = dim(2)./sum(x, 2);
end

