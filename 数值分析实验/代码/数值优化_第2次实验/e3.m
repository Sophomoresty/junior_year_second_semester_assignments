%%
% -*- coding: utf-8 -*-
% @time    : 2025/3/23 下午4:05
% @Author  : Sophomores
% @File    : e3.m
% @Software: Visual Studio Code
%%
clc, clear
n = 100;
[x, y] = meshgrid(linspace(-pi, pi, n));
z = cos(x) .* sin(y);
f1 = figure();
figure(f1)
mesh(x, y, z)

f2 = figure();
figure(f2)
surf(x, y, z)





