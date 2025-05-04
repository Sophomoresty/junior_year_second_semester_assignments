clc,clear
a = zeros(5);
for i = 1:5

    for j = 1:5
        a(i, j) = 1 / (i + j - 1);
    end

end

disp(a)