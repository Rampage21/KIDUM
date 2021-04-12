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