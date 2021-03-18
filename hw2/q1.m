%% Bayes and Linear MMSE Estimators 
% Nikita Teplitskiy, Dan Brody, and I-an Huang
clc
clear all
close all
M = 1e6;
%array to store expected and estimated MMSE and convert to table
result_arr = zeros(2,3);
%% Scenario 1 
% Implement the Bayes MMSE and Linear MMSE estimators from examples 
% 8.5 and 8.6. Simulate this system by random draws of Y and W, and then 
% estimating Y from the observations X = Y + W. Verify that your simulation
% is correct by comparing theoretical and empirical values of the MSE. 
% Report your results in a table.
%% Example 8.5 
Y = 1 - 2*rand(1,M); % $ Y in [-1,1]$
W = 2 - 4*rand(1,M); % $ W in [-2,2]$
X = Y + W;
y = arrayfun(@(x)mmse1(x),X); % shouldn't need lambda wrap but do, why?

result_arr(1,1) = 8.5;
result_arr(1,2) = 1/4;
result_arr(1,3) = mean((Y - y).^2);
% This give 1/4 which is as expected
% mean((Y - 0).^2) = 1/3 

%% Example 8.6
% Linear MMMSE 
y = 1/5*X;

result_arr(2,1) = 8.6;
result_arr(2,2) = 4/15;
result_arr(2,3) = mean((Y - y).^2);

array2table(result_arr,'VariableNames', {'Example #','Expected MMSE','Estimated MMSE'})


function yhat=mmse1(x)
    if (-3 <= x && x < -1) 
        yhat = 0.5 + .5 * x;
    elseif (-1 <= x && x < 1)
        yhat = 0;
    elseif (1 <= x && x <= 3)
        yhat = -0.5 + .5 * x;
    else 
        error("Input out of range");
    end
end
