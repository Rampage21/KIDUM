function [T03_check1, T03_check2] = sprawdzenie_pa(z)
A1_check1=mA(z(1),0,0,0);
A2_check1=mA(0,z(2),z(4),0);
A3_check1=mA(z(3),0,z(5),z(6));
T03_check1=A1_check1*A2_check1*A3_check1; 

A1_check2=mA(z(7),0,0,0);
A2_check2=mA(0,z(8),z(4),0);
A3_check2=mA(z(9),0,z(5),z(6));
T03_check2=A1_check2*A2_check2*A3_check2; 
end