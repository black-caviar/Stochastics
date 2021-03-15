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
n = 2
%% 
Y = 1 + randn(1,M);
R = randn(n,M); % make arbitrary rows of R
X = Y + R;
get_MMSE(1,1)
a = get_coeff(1, 0, 1, 1, n);
y = sum(X .* a); % + 1?

fprintf("Estimated MMSE: %f\n", mean((Y - y).^2));

% Create a function that takes 
% sigY, sigR, M returns X and sigma R and Y
% assuming sig is the same for all R?
function a = get_coeff(uY, uR, sigY, sigR, nR) 
    C = zeros(nR) + uY;
    C(1:nR+1:end) = sigY^2 + sigR^2;
    a = inv(C) * (ones(nR,1) * sigY^2); % Cxy/Cxx is better? 
end

function E = get_MMSE(sigY, sigR)
    % I didn't check if this is valid for n(R) > 2, definitely not valid
    % if several sigR are used 
    % see 8.73 
    E = (sigY^2 * sigR^2)/(2*sigY^2 + sigR^2);
end