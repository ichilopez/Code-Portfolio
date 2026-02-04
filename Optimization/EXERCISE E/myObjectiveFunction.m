function result = myObjectiveFunction(x)
    % Compute the objective function value using parameters in vector x
    result = x(1).^2 + x(2).^2 + x(1).*x(2) - 5*x(1) - 7*x(2) + 20;
end