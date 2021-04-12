clear all; clc;



% przyjęcie symboli wykorzystanych w okresleniu połozenia srodka masy
% w układzie lokalnym zwiazanym z analizowanym członem
syms a1 a2 d3 real
% zadanie wsporzednych środków masy członów względem ich lokalnych
% układów wspołrzednych
wsp=[0,0,0,1;0,-d2/2,0,1;-a3/2,0,0,1;0,0,0,1;0,0,-d5/2,1];
% przyjecie modelu rozkladu masy czlonu
R=[0,1,1,0,1];
% w manipulatorze SCARA pierwszy czlon jest pretem (nie cylindryczna kolumna)
J1=0;
% wyznaczenie symboliczne macierzy pseudoinercji J i oznaczenie mas członów
[J,ms]=fun_inert(wsp,R,J1);

% oznaczenia predkosci zlaczowych vz
syms vz1 vz2 vz3 vz4 real
vz=[vz1,vz2,vz3,vz4];
% zapis modelu geometrycznego (lab. B1)
syms th1 th2 th4 a1 a2 d3 real
gp=[th1,0,a1,0;th2,0,a2,sym(pi);0,d3,0,0;th4,0,0,0];
% wskazanie zmiennych w modelu geometrycznym
zmie=[1,0,0,0;1,0,0,0;0,1,0,0;1,0,0,0];
% oznaczenie przyspieszen zlaczowych az
syms az1 az2 az3 az4 real
az=[az1,az2,az3,az4];
% przyspieszenie ziemskie wyrazone w ukladzie odniesienia
gg=[0,0,-9.81,0];

F=fun_F(J,ms,vz,az,gg,gp,zmie,wsp);

FSS1=subs(F(1),{'m1','m2','m3','m4',a1,a2},{4,2,1,1,0.7,0.5});
FS1=double(subs(FSS1,{th1,th2,d3,th4,vz1,vz2,vz3,vz4,az1,az2,az3,az4},{q1,q2,q3,q4,v1,v2,v3,v4,ap1,ap2,ap3,ap4}));


A1=mA(th1,0,0,0);
A2=mA(0,d2,0,-pi/2);
A3=mA(th3,0,a3,0);
A4=mA(th4,0,0,-pi/2);
A5=mA(pi/2,d5,0,0);