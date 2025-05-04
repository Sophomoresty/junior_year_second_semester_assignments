clc,clear
a = 20;
b = 30;
rangdom_array = a + (b - a) * rand(1, 80);
max = 0;
min = 30;

for i = rangdom_array

    if (i >= max)
        max = i;
    elseif (i <= min)
        min = i;
    else
        continue
    end

end

disp(['80个随机分布的随机数（20≤随机数≤30）的最大值为 ' num2str(max)])
disp(['80个随机分布的随机数（20≤随机数≤30）的最小值为 ' num2str(min)])
