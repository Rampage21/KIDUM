clear all;clc;

% planowanie 10 segmentowej wielomianowej trajektorii zlaczowej
% odpowiadajacej zaplanowanemu torowi ruchu

% NR1
Q1= deg2rad([10 30 45 50 45 90 120 135 140]);
Q2=[-0.12 -0.14 -0.15 -0.35 -0.15 -0.25 -0.2 -0.15 -0.35];
Q3= deg2rad([10 20 30 40 30 20 15 30 40]);
Q4= deg2rad([-35 -60 -80 -90 -80 -15 -45 -80 -90]);

% NR2
% Q1= deg2rad([10 30 45 50 45 90 180 270 280]);
% Q2=[-0.12 -0.14 -0.15 -0.35 -0.15 -0.25 -0.2 -0.15 -0.35];
% Q3= deg2rad([10 20 30 40 30 20 15 30 40]);
% Q4= deg2rad([-35 -60 -80 -90 -80 -15 -45 -80 -90]);


% ustalenie czasow trwania ruchu na poszczegolnych odcinkach toru (w sekundach)
T=[0.1,0.1,0.5,0.5,0.1,0.1,0.1,0.5];
% zadanie wartosci poczatkowej i koncowej predkosci zlacz
% oraz wartosci poczatkowej i koncowej przyspieszenia zlacz
% (zwykle przyjmowana jest wartość 0)
V=[0 0];A=[0 0];
% planowanie trajektorii typu 555 (wyznaczenie wspolczynikow)
y1=fun_path(Q1,T,V,A);
y2=fun_path(Q2,T,V,A);
y3=fun_path(Q3,T,V,A);
y4=fun_path(Q4,T,V,A);
% zadanie wartosci rozdzielczosci czasowej
dt=0.01
% obliczenie przemieszczen, predkosci i przyspieszen zlaczowych dla 3 zlacz
wb1=waitbar(0,'obliczam przemieszczenia');
[q1,v1,aa1,tt,ti]=fun_graph(y1,T,dt,'r');
i=1;waitbar(i/3,wb1)
[q2,v2,aa2,tt,ti]=fun_graph(y2,T,dt,'b');
i=2;waitbar(i/3,wb1)
[q3,v3,aa3,tt,ti]=fun_graph(y3,T,dt,'g');
i=3;waitbar(i/3,wb1)
[q4,v4,aa4,tt,ti]=fun_graph(y4,T,dt,'m');
i=4;waitbar(i/3,wb1)
close(wb1);

syms th1 d2 th3 a3 th4 d5
% wzory na wspołrzędne kartezjanskie efektora
XX = -cos(th1)*(d5*sin(th3 + th4) - a3*cos(th3));
YY = -sin(th1)*(d5*sin(th3 + th4) - a3*cos(th3));
ZZ = d2 - d5*cos(th3 + th4) - a3*sin(th3);
% wyznaczanie toru
X=double(subs(XX,{th1,d2,th3,a3,th4,d5},{q1,q2,q3,0.5,q4,0.2}));
Y=double(subs(YY,{th1,d2,th3,a3,th4,d5},{q1,q2,q3,0.5,q4,0.2}));
Z=double(subs(ZZ,{th1,d2,th3,a3,th4,d5},{q1,q2,q3,0.5,q4,0.2}));
% wyznaczanie linii łamanej
XQ=double(subs(XX,{th1,d2,th3,a3,th4,d5},{Q1,Q2,Q3,0.5,Q4,0.2}));
YQ=double(subs(YY,{th1,d2,th3,a3,th4,d5},{Q1,Q2,Q3,0.5,Q4,0.2}));
ZQ=double(subs(ZZ,{th1,d2,th3,a3,th4,d5},{Q1,Q2,Q3,0.5,Q4,0.2}));

figure(1)
plot3(X,Y,Z);hold on
plot3(XQ,YQ,ZQ);