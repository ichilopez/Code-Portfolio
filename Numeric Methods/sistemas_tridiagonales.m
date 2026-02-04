c = input("Introduzca los elementos de la diagonal superior: \n");
d = input("Introduzca los elementos de la diagonal principal: \n");
a = input("Introduzca los elementos de la diagonal inferior: \n");
b = input('Introduzca los datos del vector de términos independientes: \n');

x = resolverSistemaTridiagonal(c,d,a,b);

% Mostramos la solución 
fprintf("La solución del sistema es: \n");
   fprintf("%d \n", x);

while(input("¿Quieres seguir utilizando la matriz introducida para resolver sistemas?\n 1 - SI 2 - NO\n") == 1)
   d = input('Introduzca los datos del vector de términos independientes: \n');
   
   x = resolverSistemaTridiagonal(c,d,a,b);

   % Mostramos la solución 
   fprintf("La solución del sistema es: \n");
   fprintf("%d \n", x);
end

function x = resolverSistemaTridiagonal(c,d,a,b)
    n = length(b);
    m = zeros(n,1);

    % mk
    m(1) = d(1);
    % Todos los menores principales tienen que ser distintos de cero 
    % para que la sucesión mk este ien definida
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