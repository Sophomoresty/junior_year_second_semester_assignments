%{
-*- coding: utf-8 -*-
@time    : 2025/4/18 19:35
@Author  : 靝Sol
@File    : e4.m
@Software: Visual Studio Code
%}
clc, clear
%% 导入数据
load data4.mat
value_name = {'年份', 'x1', 'x2', 'x3', 'x4', 'x5', 'Y'};
data4_table = array2table(data4, 'VariableNames', value_name);

X = data4_table{:, 2:end - 1};
y = data4_table{:, end};
%% 1.1 多元线性回归 不含交互项

[r, c] = size(X);
mdl = fitlm(X, y, 'y~x1+x2+x3+x4+x5');

%% 1.2 % 回归方程
% 回归系数
beta = mdl.Coefficients{:, 1};

disp(repmat('#', 1, 100))
disp('多元线性的回归方程为:')
s = sprintf('y = %f + %f * x1 + %f * x2 + %f * x3 + %f * x5 + %f * x5', beta(1), beta(2), beta(3), beta(4), beta(5), beta(6));
disp(s)
%% 1.3 显著性检验
t_pValue = mdl.Coefficients{:, "pValue"};
t_pValue = t_pValue(2:end);

summary = anova(mdl, 'summary');
f_pValue = summary{2, "pValue"};
disp(repmat('-', 1, 100))
%% F检验
if f_pValue < 0.05
    disp("模型整体具有统计显著性(a=0.05水平下), 即至少有一个自变量与因变量之间存在显著的线性关系.")
else
    disp("模型整体不具有统计显著性(显著性水平a=0.05水平下), 即自变量与因变量之间不存在显著的线性关系.")
end

%% t检验
t_logcial = t_pValue < 0.5;
t_logcial_true = [false; t_logcial];
t_logcial_flase = [false; ~t_logcial];

disp(repmat('-', 1, 100))
disp("在显著性水平a=0.05下, 以下自变量对因变量的影响具有统计显著性: ")
s = strjoin(value_name(t_logcial_true));
disp(s)
disp("在显著性水平a=0.05下, 以下自变量对因变量的影响不具有统计显著性: ")
s = strjoin(value_name(t_logcial_flase));
disp(s)
%% R2
disp(repmat('-', 1, 100))
adjust_R2 = mdl.Rsquared.Adjusted;
R2 = mdl.Rsquared.Ordinary;
s = sprintf("R2的值为 %f, 调整R2的值为 %f, 具有非常强的线性关系.", R2, adjust_R2);
disp(s)

disp(repmat('#', 1, 100))


%% 2 逐步回归
stepwise(X,y,1:5,0.05,0.10);