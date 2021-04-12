clear all; clc;

% CW B4
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
dt = 0.01;
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
%%

% przyjęcie symboli wykorzystanych w okresleniu połozenia srodka masy
% w układzie lokalnym zwiazanym z analizowanym członem
syms a3 d2 d5 real 
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
syms th1 th3 th4 a3 d2 d5 real
gp=[th1,0,0,0;0,d2,0,sym(-pi/2);th3,0,a3,0;th4,0,0,sym(-pi/2);sym(pi/2),d5,0,0];
% wskazanie zmiennych w modelu geometrycznym
zmie=[1,0,0,0;0,1,0,0;1,0,0,0;1,0,0,0;0,0,0,0];
% oznaczenie przyspieszen zlaczowych az
syms az1 az2 az3 az4 real
az=[az1,az2,az3,az4];
% przyspieszenie ziemskie wyrazone w ukladzie odniesienia
gg=[0,0,-9.81,0];

F=fun_F(J,ms,vz,az,gg,gp,zmie,wsp);

FSS1=subs(F(1),{'m1','m2','m3','m4',a3,d5},{1,2,1.5,1,0.5,0.2});
FS1=double(subs(FSS1,{th1,d2,th3,th4,vz1,vz2,vz3,vz4,az1,az2,az3,az4},{q1,q2,q3,q4,v1,v2,v3,v4,aa1,aa2,aa3,aa4}));

FSS2=subs(F(2),{'m1','m2','m3','m4',a3,d5},{1,2,1.5,1,0.5,0.2});
FS2=double(subs(FSS2,{th1,d2,th3,th4,vz1,vz2,vz3,vz4,az1,az2,az3,az4},{q1,q2,q3,q4,v1,v2,v3,v4,aa1,aa2,aa3,aa4}));

FSS3=subs(F(3),{'m1','m2','m3','m4',a3,d5},{1,2,1.5,1,0.5,0.2});
FS3=double(subs(FSS3,{th1,d2,th3,th4,vz1,vz2,vz3,vz4,az1,az2,az3,az4},{q1,q2,q3,q4,v1,v2,v3,v4,aa1,aa2,aa3,aa4}));

FSS4=subs(F(4),{'m1','m2','m3','m4',a3,d5},{1,2,1.5,1,0.5,0.2});
FS4=double(subs(FSS4,{th1,d2,th3,th4,vz1,vz2,vz3,vz4,az1,az2,az3,az4},{q1,q2,q3,q4,v1,v2,v3,v4,aa1,aa2,aa3,aa4}));


plot(tt,FS1);hold on;
plot(tt,FS2)
plot(tt,FS3)
plot(tt,FS4)

figure()
plot(tt,FS1.*v1);hold on;
plot(tt,FS2.*v2)
plot(tt,FS3.*v3)
plot(tt,FS4.*v4)