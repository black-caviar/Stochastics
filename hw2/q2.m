% make sure to put our names to our work, forgot to do that for last
% project

%% Scenario 2
% Scenario 2: Implement the linear estimator for multiple noisy 
% observations, similar to example 8.8 from the notes. Extend this example 
% so that it works for an arbitrary number of observations. Use Gaussian 
% random variables for Y and R. Set μy = 1. Experiment with a few different
% variances for both Y and R. On one plot, show the mean squared error of 
% your simulation compared to the theoretical values for at least 2 
% different pairs of variances.
clc
clear all
close all
M = 1e6;
%M=5
n = 5
%% 
sig_Y = 0.4
sig_R = 1.0

Y = 1 + sig_Y * randn(1,M);
R = sig_R * randn(n,M); % make arbitrary rows of R
X = Y + R;
get_MMSE(sig_Y, sig_R)

a = get_coeff(sig_Y, sig_R, n);
get_MMSE2(sig_Y, a)
y = 1 + sum((X-1) .* a);

fprintf("Estimated MMSE: %f\n", mean((Y - y).^2));

% Create a function that takes 
% sigY, sigR, M returns X and sigma R and Y
% assuming sig is the same for all R?
function a = get_coeff(sigY, sigR, nR) 
    % I don't think R has be zero mean or equal variance for this method
    C = zeros(nR) + sigY^2; % populate matrix with var(Y)
    C(1:nR+1:end) = sigY^2 + sigR^2; % populate diagonal with var(Xi)
    a = inv(C) * (ones(nR,1) * sigY^2); % compute coefficients 
    % Cxy/Cxx is better? 
end

function E = get_MMSE(sigY, sigR)
    % I didn't check if this is valid for n(R) > 2, definitely not valid
    % if several sigR are used 
    % see 8.73 
    E = (sigY^2 * sigR^2)/(2*sigY^2 + sigR^2);
end

function E = get_MMSE2(sigY, a)
    % Now this is the correct function for arbitrary number of R
    % can remove previous attempt 
    % see 8.73 for detail
    E = sigY^2 - sum(sigY^2 * a);
end