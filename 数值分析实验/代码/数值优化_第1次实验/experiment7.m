clc,clear
f = [220, 250];
A = [1, 1; 2, 1; 0, 1]; b = [1200; 1800; 1000];
lb = zeros(2, 1);
[x, fval] = linprog(-f, A, b, [], [], lb, []);
disp(['工厂应分别生产Ⅰ ' num2str(x(1)) '台, ' 'Ⅱ 型电冰箱' num2str(x(2)) '台, 才能使公司获益最大'])
disp(['最大收益为' num2str(-fval)])