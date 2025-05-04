function [rank,point] = func5(n)
if (n<=100 && n>=0)
    point = n/10 - 5;
    switch n
        case num2cell(90:100)
            rank = 'A';
        case num2cell(80:89)
            rank = 'B';
        case num2cell(70:79)
            rank = 'C';
        case num2cell(60:69)
            rank = 'D';
        case num2cell(0:60)
            rank = 'E';
        otherwise
            rank = '0';
            sprintf("输入内容不符合格式,请重新输入0-100的整数")
    end
else
    rank = 'error';
    point = 'error';
    sprintf("输入内容不符合格式,请重新输入0-100的整数")
end


