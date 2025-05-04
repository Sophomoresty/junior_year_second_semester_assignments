clc,clear
sum = 1;
num = 1; % 累加和

for i = 2:1000
    num = num + i;
    D = 1 / num;

    if (D > 0.001)
        sum = sum + D;
    else
        break
    end

end

disp(['累加和为 ' num2str(sum)])
disp(['累加次数为 ' num2str(i)])


