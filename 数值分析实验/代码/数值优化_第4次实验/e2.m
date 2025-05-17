% --------------------------------------------------------------------------
% Encoding : UTF-8
% @Time    : 2025/05/11 10:39:42
% @Author  : 靝Sol
% @File    : e2.m
% Software: Visual Studio Code
% Purpose : 第5次实验_题目2
% --------------------------------------------------------------------------

%
clc, clear
f = @(x) x .^ 2 + 2; % 函数

%% 外推法

% 1. 定义常量 a0,h
a0 = 2; % 初始点x0 = 2
h = 0.01; % 步长设置为0.01
f0 = f(a0);
% 初始化
a1 = a0;
f1 = f0;
a2 = a0 + h;
f2 = f(a2);

% 2. 算法



if f1 > f2

else
    h = -h;
    a3 = a1;
    f3 = f1;

    a1 = a2;
    f1 = f2;
    a2 = a3;
    f2 = f3;
end

a3 = a2 + h;
f3 = f(a3);

while ~(f3 > f2)
    h = 2 * h;
    a1 = a2;
    f1 = f2;
    a2 = a3;
    f2 = f3;
    a3 = a2 + h;
    f3 = f(a3);
end

if a1 <= a3
    a = a1; % 区间左侧
    b = a3; % 区间右侧
else
    a = a3;
    b = a1;
end

disp(repmat('#', 1, 50))
fprintf("1.外推法\n\n")
fprintf("所求单谷区间为: [%f, %f]\n\n", a, b)
disp(repmat('#', 1, 50))

%% 黄金分割法
% 1.定义常数 a1和a3一般由外推法获得,这里指定为-2,2

epi = 0.01; %收敛精度
a1 = -2;
a3 = 2;
lam = 0.618;

a2 = a3 - lam .* (a3 - a1);
f2 = f(a2);
a4 = a1 + lam .* (a3 - a1);
f4 = f(a4);
% 2.算法
while true

    if f2 > f4
        a1 = a2;
        a2 = a4;
        f2 = f4;
        a4 = a1 + lam .* (a3 - a1);
        f4 = f(a4);

    else
        a3 = a4;
        a4 = a2;
        f4 = f2;
        a2 = a3 - lam .* (a3 - a1);
        f2 = f(a2);
    end

    if ~((a3 - a1) >= epi)
        break;
    end

end

a_fin_1 = (a3 + a1) ./ 2;
f_fin_1 = f(a_fin_1);
fprintf("2.黄金分割法\n\n")
fprintf("极小值点为 %f, 极小值为 %f\n\n", a_fin_1, f_fin_1)
disp(repmat('#', 1, 50))

%% 二次插值法

% 1.定义常数

epi = 0.01;
a1 = -2;
a3 = 2;
a2 = (a1 + a3) ./ 2;
f1 = f(a1);
f2 = f(a2);
f3 = f(a3);

while true
    % 至少执行一次的部分
    c1 = (f3 - f1) ./ (a3 - a1);
    c2 = ((f2 - f1) ./ (a2 - a1) - c1) ./ ...
        (a2 - a3);
    a4 = 0.5 .* (a1 + a3 - c1 ./ c2);
    f4 = f(a4);

    % 跳出循环的条件, ~里面写循环继续的条件
    val = abs((f2 - f4) ./ f2);

    if ~(val > epi)
        break
    end

    if (a3 - a1) * (a4 - a2) > 0

        if f2 > f4
            a1 = a2;
            f1 = f2;
            a2 = a4;
            f2 = f4;
        else
            a3 = a4;
            f3 = f4;
        end

    else

        if f2 > f4
            a3 = a2;
            f3 = f2;
            a2 = a4;
            f2 = f4;
        else
            a1 = a4;
            f1 = f4;
        end

    end

end

if f2 > f4
    a_fin_2 = a4;
    f_fin_2 = f4;
else
    a_fin_2 = a2;
    f_fin_2 = f2;
end

fprintf("3.二次插值法\n\n")
fprintf("极小值点为 %f, 极小值为 %f\n\n", a_fin_2, f_fin_2)
disp(repmat('#', 1, 50))
