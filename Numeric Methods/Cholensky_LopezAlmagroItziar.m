function B = Cholensky_LopezAlmagroItziar(A)
 n = size(A,1); % Tamaño de la matriz 
 B=zeros(n);
 for i = 1:n
     for j = 1:n
         if(i==j) 
             aux=0;
             for k=1:i-1
             aux=aux+B(i,k)^2;
             end
             B(i,i)=sqrt(A(i,i)-aux);
         elseif(j<i)
             aux=0;
             for k=1:j-1
               aux=aux+B(i,k)*conj(B(j,k));
             end
             B(i,j)=(A(i,j)-aux)/B(j,j);
         end
         
     end
 end

end