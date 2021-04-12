clear all
clc
% deklaracja symboli
syms th1 th3 th4 th5 d2 d5 a3 q1 q3 q4
% wyznaczenie symbolicznej postaci macierzy HT–
% zastosowanie funkcji mA
A1=mA(th1,0,0,0);
A2=mA(0,d2,0,-pi/2);
A3=mA(th3,0,a3,0);
A4=mA(th4,0,0,-pi/2);
A5=mA(th5,d5,0,0);
% mnozenie macierzy
T0e=A1*A2*A3*A4*A5
T03=A1*A2*A3

p_a=T03*[0;0;0;1]

T3e=A4*A5
% podstawienie za obrotowe zmienne zlaczowe
% w celu uproszczenia zapisu
T03v=subs(T03,{th1,th3,th4} ,{q1,q3,q4});
% wskazanie zmiennych zlaczowych
% zmienne: th1,th2 i a3 wskazane przez‘1’
zmie=[[1,0,0,0];[0,1,0,0];[1,0,0,0];[1,0,0,0];[0,0,0,0]];
% uproszczona postac wyznaczonych macierzy HT% dla celow interpretacji przez uzytkownika
T03u=zam(zmie,T03v,'q');

T0e_n=double(subs(T0e,{th1,th3,th4,th5,d2,d5,a3},{-pi/3,pi/3,-pi/2,pi/2,-0.2,0.2,0.5}))

%stale
% a3=0.5;
d5=0.2;
% th5=pi/2;

% %dobrane zlaczowe
% th1=-pi/3; %q1
% d2=-0.2; %q2
% th3=pi/3; %q3
% th4=-pi/2; %q4

% wektory pw i pa
pw=T0e_n(1:3,3) * d5
pa=T0e_n(1:3,4) - pw

% Etap 2 analitycznie
syms pq pAx pAy pAz
pq=[pAx; pAy; pAz]

T03s=A1*A2*A3
T03ss = subs(T03s,{a3},{0.5})
Wynik2 = pq == T03ss(1:3,4)
AA = solve(Wynik2,[th1 th3, d2],'IgnoreAnalyticConstraints',true)

TH1a = simplify(AA.th1(1,1))
TH1b = simplify(AA.th1(2,1))

TH3a = simplify(AA.th3(1,1))
TH3b = simplify(AA.th3(2,1))

D2_1 = simplify(AA.d2(1,1))

% Etap 2 liczbowo

T03s=A1*A2*A3
T03ss = subs(T03s,{a3},{0.5})
Wynik2 = pa == T03ss(1:3,4)
AA = solve(Wynik2,[th1 th3, d2],'IgnoreAnalyticConstraints',true)

TH1a = rad2deg(double(AA.th1(1,1)))
TH1b = rad2deg(double(AA.th1(2,1)))

TH3a = rad2deg(double(AA.th3(1,1)))
TH3b = rad2deg(double(AA.th3(2,1)))

D2_1 = double(AA.d2(1,1))

% Etap 3
T03_etap3=subs(T03,{th1,th3,d2,a3},{-pi/3,pi/3,-0.2,0.5});

X = simplify(T03_etap3(1:3,1:3)'*T0e_n(1:3,1:3))
Y = subs(T3e(1:3,1:3),{th5,d5},{pi/2,0.2})

assume(th4<0 & th4>-pi) % przyjęto zakres wartości zmiennej
q4_s = rad2deg(solve(X == Y))