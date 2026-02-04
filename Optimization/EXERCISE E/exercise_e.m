% Objective function
f = @(x, y) x.^2 + y.^2 + x.*y - 5*x - 7*y + 20;


% Partial derivatives
df_dx = @(x, y) 2*x + y - 5;
df_dy = @(x, y) 2*y + x - 7;

% Parameters
alpha = 0.4; % Learning rate
max_iterations = 1000; % Maximum number of iterations
tolerance = 1e-5; % Convergence criterion
error=1e-2;%error we will accept for confirming that the results of the algorithm are correct
x = 2; % Initial x
y = 2; % Initial y

% Gradient descent iterations
for iter = 1:max_iterations
    % Store the current objective value
    f_current = f(x, y);

    % Update parameters
    x_new = x - alpha * df_dx(x, y);
    y_new = y - alpha * df_dy(x, y);

    % Update parameters for the next iteration
    x = x_new;
    y = y_new;

    % Calculate the new objective value
    f_new = f(x, y);

    % Check for convergence
    if abs(f_new - f_current) < tolerance
        disp(['Converged in ', num2str(iter), ' iterations.']);
        break;
    end
end

% Display the final result
disp(['Final parameters: x = ', num2str(x), ', y = ', num2str(y)]);
disp(['Final objective value: ', num2str(f(x, y))]);


%we will use the MATLAB function fminunc that for calculating the minimum
%of f
%this are the argument we will have to pass to the function
x0=[2,2];

[x_opt, f_opt] = fminunc(@myObjectiveFunction, x0);
disp(['Final actual values of the minimum of the function f: x = ', num2str(x_opt(1)), ', y = ', num2str(x_opt(2)),' and f(x,y)=',num2str(f_opt)]);

if abs(x_opt(1) - x) <error && abs(x_opt(2) - y) < error && abs(f(x,y) - f_opt) <error 
    disp('We can confirm that our results are correct');
else 
    disp('Our results are not correct');
end

