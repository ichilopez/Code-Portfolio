
function [L,U]=FactorizacionLU_LopezAlmagroItziar(A)
    n=size(A,1);
    U=zeros(n);
    L=zeros(n);
    if n> 1
        for i = 1 : n
            % Calculamos los elementos uij y lji
            for j = 1:n
                if(i<=j)
                U(i,j) = A(i,j) - dot(L(i,1:i-1),U(1:i-1,j));
                else
                L(i,j) = (A(i,j) - dot(L(i,1:j-1),U(1:j-1,j)))/U(j,j);
                end
            end
        end 
    end

   