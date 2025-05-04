%{
-*- coding: utf-8 -*-
@time    : 2025/4/18 19:35
@Author  : 靝Sol
@File    : e2.m
@Software: Visual Studio Code
%}
clc, clear

%% 多项式回归
load data2.mat
x = data2(1, :);
y = data2(2, :);

% 有bug, 这里拟合接收用p和[p,S] 算出的p都是正确的, 但[p,S,mu]的p值是错误的
[p, S, ] = polyfit(x, y, 2);

x_test = linspace(0, 20, 100);
y_predict = polyval(p, x_test);
%% 画图(可以不用画)
s = sprintf('y = %.3fx^2 + %.3fx + %.3f', p(1), p(2), p(3));

% set(gcf, 'unit', 'normalized', 'position', [0.2, 0.2, 0.5, 0.5])

% plot(x, y, 'bo', x_test, y_predict, 'r-')

% grid on



% str = {'纵坐标y关于横坐标x的二次多项式回归方程:', s};

% text(2, 60, str, "FontSize", 20, "FontName", '宋体', 'Color', 'black')

% legend({'原数据', '二次多项式回归拟合图'}, "FontName", '宋体', 'FontSize', 15, 'Location', 'west', 'Position', [0.2 0.5 0.1 0.1])
disp("多项式回归的方程为: ")
disp(s)