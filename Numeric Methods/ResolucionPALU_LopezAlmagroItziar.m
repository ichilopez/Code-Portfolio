function x=ResolucionPALU_LopezAlmagroItziar(ptr,L,U,b)
A=L+U;
A=A(ptr,:);
  n = size(A,1);
    y= zeros(n, 1);
    y(1)=b(ptr(1));
    for i = 2 :  n
        y(i) = b(ptr(i)) - dot(A(ptr(i), 1: i-1),y(1:i-1));
    end
    x= zeros(n, 1);
    x(n)=y(n)/A(ptr(n),n);
    for i = n-1 :-1: 1
        x(i) = (y(i) - dot(A(ptr(i), i+1:n),x(i+1:n)) )/A(ptr(i),i);
    end
end