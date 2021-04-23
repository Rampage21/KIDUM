% formulowanie rownan dynamicznych ruchu
% dla struktury kinematycznej RRP
clear; clc;
syms J1 m2 a2 m3 g t real
syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 real
% parametry kinematyczne (przemieszczenia, predkosci, przyspieszenia)
q=[q1,q2,q3];
dq=[dq1,dq2,dq3];
ddq=[ddq1,ddq2,ddq3];

% zmiana oznaczen parametrow kinematycznych
qt=[str2sym('q1(t)'),str2sym('q2(t)'),str2sym('q3(t)')];
dqt=[str2sym('dq1(t)'),str2sym('dq2(t)'),str2sym('dq3(t)')];
dqtt=[str2sym('diff(q1(t), t)'),str2sym('diff(q2(t),t)'),str2sym('diff(q3(t), t)')];
ddqt=[str2sym('diff(dq1(t), t)'),str2sym('diff(dq2(t),t)'),str2sym('diff(dq3(t), t)')];

% energia kinetyczna
Ek1 = 1/2*J1*dq1^2;
Ek2 = 1/2*(J2+m2*p2^2)*cos(q2)^2*dq1^2+1/2*(J2+m2*p2^2)*dq2^2;
Ek3 = 1/2*m3*(q3^2*cos(q2)^2*dq1^2+q3^2*dq2^2+dq3^2);
Ek = simplify(Ek1+Ek2+Ek3);
% energia potencjalna
Ep1 = 0;
Ep2 = -m2*g*sin(q2)*p2;
Ep3 = -m3*g*sin(q2)*q3;
Ep=simplify(Ep1+Ep2+Ep3);
% potencjal kinetyczny L
L=Ek-Ep;
% rownania Lagrange’a drugiego rodzaju
% pochodna L wzgledem dq
f1=jacobian(L,dq);
% wprowadzenie zmiennej czasowej t
f2=subs(f1,q,qt);
f3=subs(f2,dq,dqt);
% pochodna f3 względem czasu t
f4=diff(f3,t);
% ujednolicenie oznaczen i usuniecie zmiennej t
f5=subs(f4,ddqt,ddq);
f6=subs(f5,dqt,dq);
f7=subs(f6,dqtt,dq);
f8=subs(f7,qt,q);
% pochodna L wzgledem q
f9=jacobian(L,q);
% zestawienie prawej strony rownan dynamicznych ruchu DEM
DEM=f8-f9;
