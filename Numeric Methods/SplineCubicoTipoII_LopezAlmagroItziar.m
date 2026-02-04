function Y =SplineCubicoTipoII_LopezAlmagroItziar(x,y,dy0,dyn,X)
% Subíndice maximo de los puntos xi
n = size(x,2) - 1;

% Creamos e inicializamos los vectores necesarios para el calculo de los momentos
h = zeros(n,1);
lambda = zeros(n,1);
mu = zeros(n,1);
d = zeros(n+1,1);
h(1) = x(2) - x(1); 
for j = 1 : n-1
    h(j+1) = x(j+2) - x(j+1);
    lambda(j+1) = h(j+1)/(h(j) + h(j+1));
    mu(j) = 1 - lambda(j+1);
    d(j+1) = 6/(h(j) + h(j+1)) * ((y(j+2) - y(j+1))/h(j+1) - (y(j+1) - y(j))/h(j));
end
mu(n) = 1;
d(1) = 6/h(1) * ((y(2) - y(1))/h(1) - dy0);
 d(n+1) = 6/h(n) * (dyn - (y(n+1) - y(n))/h(n));
D = 2.* ones(length(x),1);
M = resolverSistemaTridiagonal(lambda,D,mu,d);
for j = 1:n
    alfa = y(j);
    beta = (y(j+1) - y(j))/h(j) - (2*M(j) + M(j+1))/6 * h(j);
    gamma = M(j)/2;
    delta = (M(j+1)-M(j))/(6*h(j));
    % Polinomio en el intervalo [xj, xj+1]
    Pn{j} = @(x) alfa+beta*(x)+gamma*(x).^2+delta*(x).^3;
end
N=length(X);
n=length(x);
for i = 1:N
    for j=1:n-1
        if(X(i)>=x(j) && X(i)<=x(j+1))
            Y(i)=Pn{j}(X(i)-x(j));
        end
    end
end

end

function x = resolverSistemaTridiagonal(c,b,a,d)
    n = length(d);

    % Calculamos la sucesiones del apartado 7b)
    m = zeros(n,1);
    % mk
    m(1) = b(1);
    % Todos los menores principales tienen que ser distintos de cero 
    % para que la sucesión mk este bien definida
    if m(1) == 0
        error("ERROR: El menor principal de orden 1 de la matriz A es nulo")
    end

    for k = 2:n
        m(k) = b(k) - c(k-1)/ m(k-1)*a(k-1);
        if m(k) == 0
            error("ERROR: El menor principal de orden " + k + " de la matriz A es nulo");
        end
    end

    % gk
    g = zeros(n, 1);
    g(1) = d(1)/m(1);
    for k = 2:n
        g(k) = (d(k) - g(k-1) * a(k-1)) / m(k);
    end

    % La solución viene dada por las formulas del apartado 7c
    x(n) = g(n);
    for k = n-1:-1:1
        x(k) = g(k) - c(k) / m(k) * x(k+1);
    end
  

end