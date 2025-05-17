% --------------------------------------------------------------------------
% Encoding : UTF-8
% @Time    : 2025/05/11 10:39:03
% @Author  : 靝Sol
% @File    : e1.m
% Software: Visual Studio Code
% Purpose : 第5次实验_题目1
% --------------------------------------------------------------------------

%
clc,clear
% 定义常量

% kgf = N(牛顿)
P = 1000; % 集中载荷 (kgf)
sigma = 1000; % 材料强度 (kgf/cm^2)
tau = 750; % 剪切应力最大值 (kgf/cm^2)
E = 7.03e5; % 弹性模量 (kgf/cm^2)
f = 0.01; % 允许扰度 (cm)

% x(1) = l, x(2) = d

% 目标函数：最小化体积
objective = @(x) (pi * x(2) ^ 2/4) * x(1);

% 线性不等式约束条件
A = [];
b = [];
% 线性等式约束条件
Aeq = [];
beq = [];

% 非线性约束条件 c(x)<=0 ceq(x) = []
nonlcon = @(x) deal( ...
    [ (32 * 1000 * x(1)^2) / (pi * x(2)^4) - 1000;  % 强度约束
      (1000 * x(1)^3) / (3 * 7.03e5 * (pi * x(2)^4 / 64)) - 0.01;  % 刚度约束
      (4 * 1000) / (pi * x(2)^2) - 750;],...% 剪切力约束
      []);

% 变量范围
lb = [5, 2]; % 下界 最小值 l = 5, d = 2
ub = [15, 10]; % 上届最大值 l = 15, d = 10

% 初始值
x0 = (lb + ub) / 2;

% 使用fmincon进行优化,显示每次迭代结果
options = optimset('Display', 'iter');
[x_opt, fval] = fmincon(objective, x0, A, b, Aeq,beq, lb, ub, nonlcon, options);

% 输出优化结果
fprintf("优化后的设计: l = %f cm, d = %f cm\n",x_opt(1),x_opt(2))

fprintf("最小体积为: %f cm^3",fval)
