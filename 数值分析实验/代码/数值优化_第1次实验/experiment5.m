clc, clear
n = input('请输入你的分数(0-100内的整数): ');
[rank, point] = func5(n);

if (rank == 'error' | point == 'error')
else
    disp(['绩点为 ' num2str(point)])
    disp(['成绩等级为 ' num2str(rank)])
end
