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
mmse = @(x1,x2) mean((x1-x2).^2);
M = 1e3;
%% 
X_exp = exprnd(1, 1, M) % What should the mean be?
X_ray = raylrnd(