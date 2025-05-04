%{
-*- coding: utf-8 -*-
@time    : 2025/4/18 19:35
@Author  : 靝Sol
@File    : e3.m
@Software: Visual Studio Code
%}
clc, clear
%% 导入数据
load data3.mat

value_name = {'序号', '反应速度 y', '氢 x1', 'n戊烷 x2', '异构戊烷 x3'};
data3_table = array2table(data3, "VariableNames", value_name);

% 回归计算中, 可以使用表格数据计算, 但数值矩阵比较方便, 和平常的操作一样

X = data3_table{:, 3:end}; % 使用{}提取数值数据
y = data3_table{:, 2};

%% 建立模型
model_func = @(b, X) (b(1) .* X(:, 2) - X(:, 3) / b(5)) ./ ...
    (1 + b(2) .* X(:, 1) + b(3) .* X(:, 2) + b(4) .* X(:, 3));

% 初始参数
beta0 = ones(1, 5);

%% 非线性回归
mdl = fitnlm(X, y, model_func, beta0);

%% 显示结果

result = mdl.coefCI;
disp(repmat('#', 1, 100))
disp('b1-b5的置信区间')
% bi的置信区间为 xxx - xxxx
for i = 1:5
    formatSpec = "b%d的置信区间为 %.4f --- %.4f";
    str = sprintf(formatSpec, i, result(i, 1), result(i, 2));
    disp(str)
end

disp(repmat('#', 1, 100))