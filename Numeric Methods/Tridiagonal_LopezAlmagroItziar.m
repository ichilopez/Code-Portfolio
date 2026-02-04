function x= Tridiagonal_LopezAlmagroItziar(d,a,c,b)
   seguir=1;
   n = length(b);
   m = zeros(n,1);
    % mk
    m(1) = d(1);
    % Todos los menores principales tienen que ser distintos de cero 
    % para que la sucesión mk este bien definida
    if m(1) == 0
        error("ERROR: El menor principal de orden 1 de la matriz A es nulo")
    end

    for k = 2:n
        m(k) = d(k) - c(k-1)/ m(k-1)*a(k-1);
        if m(k) == 0
            error("ERROR: El menor principal de orden " + k + " de la matriz A es nulo");
        end
    end

    % gk
    g = zeros(n, 1);
    g(1) = b(1)/m(1);
    for k = 2:n
        g(k) = (b(k) - g(k-1) * a(k-1)) / m(k);
    end

    % La solución viene dada por las formulas del apartado 7c
    x(n) = g(n);
    for k = n-1:-1:1
        x(k) = g(k) - c(k) / m(k) * x(k+1);
    end
end