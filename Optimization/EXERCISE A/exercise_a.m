% Define the range for x and y
x = linspace(-2, 4, 100); % 100 points from -2 to 4
y = linspace(-2, 4, 100); % 100 points from -2 to 4

% Create a grid of values for x and y
[X, Y] = meshgrid(x, y);

% Define your bivariate function (for example, z = x^2 + y^2)
Z = X.^2 + Y.^2 + X.*Y - 5*X -7*Y +20;

% Plot the bivariate function using mesh
mesh(X, Y, Z);

% Customize the plot
title('Plot of z = x^2 + y^2+ xy -5x -7y +20');
xlabel('x');
ylabel('y');
zlabel('z');
grid on;

% Show the plot