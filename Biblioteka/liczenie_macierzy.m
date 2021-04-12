function [A1 A2 A3 A4 A5 T03 T0e] = liczenie_macierzy(x)
A1=mA(x(1),0,0,0);
A2=mA(0,x(2),0,x(6));
A3=mA(x(3),0,x(5),0);
A4=mA(x(4),0,0,x(7));
A5=mA(x(8),x(9),0,0);
T03=A1*A2*A3; 
T0e=A1*A2*A3*A4*A5; 
end