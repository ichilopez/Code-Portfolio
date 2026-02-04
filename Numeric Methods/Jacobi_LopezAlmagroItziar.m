function [u_k,Norma] = Jacobi_LopezAlmagroItziar(A,b)
eps=0.0005;
max_it=1000;
% Transformamos el vector de términos independientes en un vector columna 
b = b(:);
n = size(A, 1);
d = zeros(n, 1);

% Vector residuo
r = zeros(n, 1);
% Sucesión de iteraciones
u_k = zeros(n,1);
% Vector de errores relativos
v = zeros(max_it, 1);
Norma=1;

for i = 1 : max_it
    % Calculamos el vector residuo para aplicar la condición de parada
    r = b - A*u_k;

    % Error relativo
    v(i) = norm(r)/norm(b);

    % Paramos las iteraciones cuando ||r^k||/||b|| < epsilon 
    if v(i) < eps
        fprintf("Se ha cumplido la condición de parada\n");
        Norma=v(i);
        break;
    end

    % Calculos correspondientes del método de Jacobi en la i-esima
    % iteración

    d = r./diag(A);
    u_k = u_k + d;
end

% Si no ha sido suficiente con las iteraciones
if i == max_it
    fprintf("El método iterativo no converge.\n");
end
end