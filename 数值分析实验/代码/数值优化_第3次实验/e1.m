%{
-*- coding: utf-8 -*-
@time    : 2025/4/18 19:35
@Author  : 靝Sol
@File    : e1.m
@Software: Visual Studio Code
%}
%% 载入数据
clc, clear
load data1.mat
x = data1(1, :);
y = data1(2, :);
%% 回归
Lxx = sum((x - mean(x)) .^ 2);
Lxy = sum((x - mean(x)) .* (y - mean(y)));

b1 = Lxy / Lxx;
b0 = mean(y) - mean(x) * b1;

y1 = b0 + b1 * x;
disp(repmat('#', 1, 100))
disp(['问题1' newline])
s = sprintf("y = %f + %f * x1 ",b0,b1);
disp("一维线性回归方程为: ")
disp(s)

%% 计算统计量

TSS = sum((y - mean(y)) .^ 2);
ESS = sum((y1 - mean(y)) .^ 2);
RSS = sum((y - y1) .^ 2);
sgm2 = RSS / (size(x, 2) - 2);
F = ESS / RSS / (size(x, 2) - 2);
t = Lxy / sqrt(Lxx * sgm2);
R2 = ESS / TSS;

% 置信水平95
a = 0.05;
F_reject_domain = finv( 1 - a, 1, size(x, 2) - 2); % 计算F分布 cdf在0.95时对应的x值
t_reject_domain = tinv(1-a/2, size(x) - 2);
t_reject_domain = t_reject_domain(2);

reject_domain = [F, t, R2; F_reject_domain, t_reject_domain, 0.8];
reject_domain_name = {'F检验', 't检验', '可决系数R2检验'};
%% 展示统计量
disp(repmat('#', 1, 100))
disp(['问题2' newline])

for i = 1:size(reject_domain, 2)

    if i ~= 3
        % x检验值为x, xx置信度对应的cdf为
        f1 = "%s值为 %f, %d%%置信度的%s临界值为 %f";
        s1 = sprintf(f1, reject_domain_name{i}, reject_domain(1, i), (1 - a)*100,reject_domain_name{i}, reject_domain(2, i));
        disp(s1)
    end

end

%% 展示显著性检验结果
for i = 1:size(reject_domain, 2)

    if (reject_domain(1, i) > reject_domain(2, i)) && i < 3

        f2 = "在显著性水平%.2f下, 本次回归通过%s, 表明自变量对因变量的线性关系显著";
        s2 = sprintf(f2,a,reject_domain_name{i});
        disp(s2)

    elseif (reject_domain(1, i) <= reject_domain(2, i)) && i < 3
        f3 = "在显著性水平%.2f下, 本次回归未通过%s, 表明自变量对因变量的线性关系不显著";
        s3 = sprintf(f3,a,reject_domain_name{i});
        disp(s3)

    elseif (reject_domain(1, i) > reject_domain(2, i))

        % 可决系数R2: xxx > 0.8, 本次回归的拟合程度较好
        f4 = "%s的值: %f > %f, 故本次回归的拟合程度较好";
        s4 = sprintf(f4,reject_domain_name{i},reject_domain(1,i),reject_domain(2,i));
        disp(s4)


    elseif (reject_domain(1, i) < reject_domain(2, i))
        f4 = "%s的值: %f < %f, 故本次回归的拟合程度较差";
        s4 = sprintf(f4,reject_domain_name{i},reject_domain(1,i),reject_domain(2,i));

        disp([reject_domain_name{3} ' < 0.8, 本次回归的拟合程度较差'])

    end

end

y_predict = b0 + b1 * 180;

disp(repmat('#', 1, 100))
disp(['问题3' newline])
disp(['若在XX市购买180平方米的房屋, 估计购房费用为 ' num2str(y_predict)])

disp(repmat('#', 1, 100))