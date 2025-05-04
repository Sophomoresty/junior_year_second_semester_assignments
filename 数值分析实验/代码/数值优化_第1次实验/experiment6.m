x = linspace(0, 2 * pi, 150);
y = cos(x) .* (0.5 + 3 .* sin(x) ./ (1 + x .^ 2));
plot(x, y)
