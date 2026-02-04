function [ptr,L,U] = FactorizacionPALU_LopezAlmagroItziar(A)
N = size(A,1);
ptr = 1:N; %
for j=1:N      
    [maxVal,i] = max(abs(A(ptr(j:N),j)));
    i = i+j-1;
    if (maxVal == 0)
        error('La matriz no es inversible.');
    end
    [ptr(j),ptr(i)] = deal(ptr(i),ptr(j));
    A(ptr(j+1:N),j) = A(ptr(j+1:N),j)/A(ptr(j),j);
    for i=j+1:N
        A(ptr(i),j+1:N) = A(ptr(i),j+1:N)-A(ptr(i),j)*A(ptr(j),j+1:N); 
    end
    A_ordered=A(ptr,:)
    U=triu(A_ordered);
    L=tril(A_ordered,-1);
end
end