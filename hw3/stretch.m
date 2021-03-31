%% Change Point Estimation 
% Nikita Teplitskiy 
clearvars
close all
%%
close all
n = randi(100)
l1 = randi(100)-1
l2 = randi(100)-1

y = [poissrnd(l1, 1, n), poissrnd(l2, 1, 100-n)]

histogram(y,20,'Normalization','pdf')
hold on
plot(0:100, poisspdf(0:100,l1))
plot(0:100, poisspdf(0:100,l2))

function y=pwasan(k, l)
    
end