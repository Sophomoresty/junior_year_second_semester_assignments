%%
% -*- coding: utf-8 -*-
% @time    : 2025/3/23 下午4:05
% @Author  : Sophomores
% @File    : e2.m
% @Software: Visual Studio Code
%%
clc, clear
load data2.mat
x = data2(:, 2:end);
[r, c] = size(x);
% 将标题保存为字符, 放在元胞数组中
x_label = {'生铁产量(万吨)', '金属切削机床产量(万台)', '汽车产量(万辆)'};

%% 1)
disp(['第一题' newline])
[mean_x, triple_mean_x, std_x, v_x, sk_x, ku_x] = func2(x);
for i = 1:c
    disp(['第' num2str(i) '个指标 < ' x_label{1, i} ' > 的统计量'])
    disp(['平均值为: ' num2str(mean_x(1, i))])
    disp(['三均值为: ' num2str(triple_mean_x(1, i))])
    disp(['标准差为: ' num2str(std_x(1, i))])
    disp(['变异系数为: ' num2str(v_x(1, i))])
    disp(['偏度为: ' num2str(sk_x(1, i))])
    disp(['峰度为: ' num2str(ku_x(1, i))])

    if i < 3
        disp(repmat('-', 1, 50))
    end

end

%% 2)
disp([newline repmat('#', 1, 50)])
disp(['第二题' newline])

distribution_test_value = zeros(3, 3);
% distribution_test_value 3行3列
% 1,2,3列分别表示指标 '生铁产量(万吨)', '金属切削机床产量(万台)', '汽车产量(万辆)'
% 第1行表示 JB检验的值 0为接受正态分布假设, 1为不接受正态分布假设, 下同
% 第2行表示 KS检验的值
% 第3行表示 改进KS检验的值
f1 = figure("Name", '各项指标的Q-Q图');
set(gcf, 'unit', 'normalized', 'position', [0.2, 0.2, 0.5, 0.5])
% i表示指标所在的列
for i = 1:c
    distribution_test_value(1, i) = jbtest(x(:, i));
    distribution_test_value(2, i) = kstest(x(:, i));
    distribution_test_value(3, i) = lillietest(x(:, i));
    figure(f1)
    subplot(1, 3, i); qqplot(x(:, i))
    title([x_label{1, i} '的Q-Q图'])
    ylabel([x_label{1, i} '的分位数'])
end

% 指标 不符合正态分布的次数
judge_value = sum(distribution_test_value, 1);
% 不符合正态分布的列, 符合为1, 不符合为0
not_norm_col = ones(1, 3);

for i = 1:c

    if judge_value(1, i) > 0
        disp(['指标 <' x_label{1, i} '> 不服从正态分布'])
        not_norm_col(1, i) = 0;
    else
        disp(['指标 <' x_label{1, i} '> 服从正态分布'])
        % 计算95%概率时的值, 不是计算95分位数的值
        % 在理论层面，正态分布的95分位数即为其CDF达到95%时的值，两者等同。
        % 实际样本中，若数据严格服从正态分布且样本量充分，两者近似等同
        disp(['概率为95%时的' x_label{1, i} '为' prctile(x(:, i), 95, 'all')])
        disp(['概率为95%时的' x_label{1, i} '为' prctile(x(:, i), 95, 'all')])
    end

end

% 对不符合正态分布的列 进行box-cox变换, 需要提前初始化矩阵
not_norm_num = sum(not_norm_col == 0); % 不符合正态分布的指标个数

% x_b用于保存变换后的指标列
x_b = zeros(r, not_norm_num(1, 1));

f2 = figure("Name", '不符合正态分布的指标的原始数据与变换数据的Q-Q图');
set(gcf, 'unit', 'normalized', 'position', [0.2, 0.2, 0.5, 0.5])

for i = 1:c

    if not_norm_col(1, i) == 0

        disp(['正在使用Box-Cox对指标 < ' x_label{1, i} ' > 进行变换'])
        [x_b(:, i), t] = boxcox(x(:, i));
        figure(f2)
        subplot(2, not_norm_num(1, 1), i); normplot(x(:, i)) % 原始数据的QQ图
        title([x_label{1, i} '原始数据的Q-Q图'])

        subplot(2, not_norm_num(1, 1), i + 3); normplot(x_b(:, i)) % 变换数据的的QQ图
        title([x_label{1, i} '变换数据的Q-Q图'])
    end

end

% 打印变换后的指标的统计量数据, 未变换的不打印
[mean_x_b, triple_mean_x_b, std_x_b, v_x_b, sk_x_b, ku_x_b] = func2(x_b);
disp(repmat('-', 1, 50))

for i = 1:size(x_b, 2)
    disp(['第' num2str(i) '个不符合正态分布的指标 < ' x_label{1, i} ' > 变换后的统计量'])
    disp(['平均值为: ' num2str(mean_x_b(1, i))])
    disp(['三均值为: ' num2str(triple_mean_x_b(1, i))])
    disp(['标准差为: ' num2str(std_x_b(1, i))])
    disp(['变异系数为: ' num2str(v_x_b(1, i))])
    disp(['偏度为: ' num2str(sk_x_b(1, i))])
    disp(['峰度为: ' num2str(ku_x_b(1, i))])
    if i < 3
        disp(repmat('-', 1, 50))
    end

end

%% 3)
d = mahal(x, x); % 计算马氏距离
dl = sort(d); % 从小到大排序
pt = ((1:r) - 0.5) / r; % 计算分位数
x2 = chi2inv(pt, c); % 计算卡方
f3 = figure("Name", '3项指标的多维正态检验Q-Q图');
set(gcf, 'unit', 'normalized', 'position', [0.2, 0.2, 0.5, 0.5])
figure(f3)
plot(dl, x2, '*', 0:10, 0:10, '-r')
