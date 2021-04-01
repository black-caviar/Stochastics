%% Change Point Estimation 
% Nikita Teplitskiy 
clearvars
close all
%%
close all
n = randi(100)
l1 = randi(100)-1
l2 = randi(100)-1

y = [poissrnd(l1, 1, n), poissrnd(l2, 1, 100-n)];

histogram(y,20,'Normalization','pdf')
hold on
plot(0:100, poisspdf(0:100,l1))
plot(0:100, poisspdf(0:100,l2))

est = zeros(101,2);
lhat = @(x) sum(x)/length(x);

for i=0:100
    est(i+1,:) = [lhat(y(1:i)), lhat(y(i+1:end))];
end


plot(0:100, l1+zeros(1,101));
plot(0:100, l2+zeros(1,101));
plot(0:100,est', 'LineWidth', 2)