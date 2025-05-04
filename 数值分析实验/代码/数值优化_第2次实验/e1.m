%%
% -*- coding: utf-8 -*-
% @time    : 2025/3/23 下午4:05
% @Author  : Sophomores
% @File    : e1.m
% @Software: Visual Studio Code
%%
clc, clear
x = normrnd(5, sqrt(20), [1, 160]); % 正态分布随机样本
% x = 5+20*randn(1,120);
x_mean = mean(x);
x_range = range(x);


set(gcf, 'unit', 'normalized', 'position', [0.2, 0.2, 0.5, 0.5]); %其在屏幕上的显示，四个参数分别表示的是左边界，下边界，高度，宽度。
% 绘制直方图
subplot(1, 2, 1); histogram(x);
subplot(1, 2, 1); histfit(x);
legend('直方图', '正太分布拟合曲线','Location', 'southeast')

% 绘制样本的经验分布函数图
subplot(1, 2, 2); [h, stats] = cdfplot(x);
hold on
% 绘制理论分布函数图
plot(-60:0.01:60, normcdf(-60:0.01:60,5,sqrt(20)), 'r');
legend('样本经验分布函数图', '理论分布函数图', 'Location', 'southeast')
hold off