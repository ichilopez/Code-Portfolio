function [Y1,Y2] = InterpolacionPolinomica_LopezAlmagroItziar(x,y,X) 
   %máximo subíndice de los puntos  
   n = length(x) - 2;
   % Funcion pi de la formúla de Interpolación de Newton
   pi = ones(1);
   % Polinomio de interpolación
   Pn = double.empty;
   N=length(X);
   %Direncias divididas, f[xi] = f(xi)
   diff = zeros(1,n+1);
   diff(1:n+1) = y(1:n+1);

   for i = 0:n
        % Calculamos el polinomio de interpolación de f en los puntos x0..xi
        Pn = [0, Pn] + pi*diff(1);
    
        % Calculamos la función pi de la siguiente iteración
        pi = [pi, 0] - [0, pi.*x(i+1)];
    
        % Calculamos las diferencias divididas
        for j = 1:n-i
            diff(j) = (diff(j) - diff(j+1))/(x(j) - x(j+i+1));
        end
   end
   for i=1:N
       Y1(i)=polyval(Pn,X(i));
   end
   %ahora, agregamos un punto
   n=n+1;
        diff = [diff, y(end)];
        % Calculamos la nueva diferencia dividida
        for i = n:-1:1
            diff(i) = (diff(i) - diff(i+1))/(x(i) - x(n+1));
        end

        % Calculamos el polinomio de interpolación con el nuevo punto
        Pn = [0, Pn] + pi*diff(1);
        for i=1:N
         Y2(i)=polyval(Pn,X(i));
        end        
end