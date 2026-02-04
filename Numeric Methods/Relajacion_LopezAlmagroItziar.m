function [u_k,precision] = Relajacion_LopezAlmagroItziar(A,b,w)
n = size(A, 1);
d = zeros(n, 1);
max_it=1000;
eps=0.0005;
r = zeros(n, 1);
% Sucesión de iteraciones
u_k = zeros(n,1);

for i = 1 : max_it
    % Calculos correspondientes del método de Jacobi en la i-esima
    % iteración
    for j = 1: n
        r(j) = b(j) - A(j,1:j-1)*u_k(1:j-1) - A(j, j:n)*u_k(j:n);
        d(j) = w*(r(j)/A(j, j));
        u_k(j) = u_k(j) + d(j);
    end
    

    % Error relativo (tambien puede hacerse con la norma infinito)
   precision= norm(r)/norm(b);

    % Paramos las iteraciones cuando ||r^k||/||b|| < epsilon 
    if precision < eps
        fprintf("Se ha cumplido la condición de parada\n");
        break;
    end
end

% Si no ha sido suficiente con las iteraciones
if i == max_it
    fprintf("El método iterativo no converje.\n");
end
end