%%
% -*- coding: utf-8 -*-
% @time    : 2025/3/23 下午4:05
% @Author  : Sophomores
% @File    : func2.m
% @Software: Visual Studio Code
%%
function [mean_x, triple_mean_x, std_x, v_x, sk_x, ku_x] = func2(x)
    % 输入: 样本矩阵
    % 输出统计量

    %% 1 平均值
    mean_x = mean(x, 1); % 平均值

    %% 2 三均值
    % prctile(x, [25 50 75], 1) % x每列的25 50 75分位数
    triple_mean_x = [0.25, 0.5, 0.25] * prctile(x, [25, 50, 75], 1);

    %% 3 标准差
    std_x = std(x, 0, 1);
    %% 4 变异系数
    v_x = std_x ./ abs(mean_x);
    %% 5.偏度与峰度
    % 偏度
    sk_x = skewness(x, 1, 1);
    % 峰度
    ku_x = kurtosis(x, 1, 1);

end
