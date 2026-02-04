% Objective function
f = @(x, y) x.^2 + y.^2 + x.*y - 5*x - 7*y + 20;

% Partial derivatives
df_dx = @(x, y) 2*x + y - 5;
df_dy = @(x, y) 2*y + x - 7;

% Parameters
alpha = 0.4; % Learning rate
max_iterations = 1000; % Maximum number of iterations
tolerance = 1e-5; % Convergence criterion
x = 2; % Initial x
y = 2; % Initial y

% Gradient descent iterations
for iter = 1:max_iterations
    % Store the current objective value

    % Update parameters
    x_new = x - alpha * df_dx(x, y);
    y_new = y - alpha * df_dy(x, y);

    % Update parameters for the next iteration
    x = x_new;
    y = y_new;

    % Calculate the new objective value
    f_new = f(x, y);
    disp(['Value of f_',num2str(iter),' is ',num2str(f_new)]);

    % Check for convergence
    if iter~=1 && abs(f_new - f_current) < tolerance 
        disp(['Converged in ', num2str(iter), ' iterations.']);
        break;
    end
     f_current = f_new;
end

% Display the final result
disp(['Final parameters: x = ', num2str(x), ', y = ', num2str(y)]);
disp(['Final objective value: ', num2str(f(x, y))]);
