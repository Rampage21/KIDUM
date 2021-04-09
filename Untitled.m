clear all;
clc

% deklaracja symboli
syms th1 th3 th4 th5 d2 d5 a3 q1 q3 q4

%stale
a3=0.5;
d5=0.2;

%dobrane zlaczowe
TH1= deg2rad(rand*360-180); %q1
D2=-rand*0.3-0.1; %q2
TH3=deg2rad(rand*180); %q3
TH4=deg2rad(-rand*180); %q4

% TH1= deg2rad(-60); %q1
% D2=-0.2; %q2
% TH3=deg2rad(60); %q3
% TH4=-deg2rad(90); %q4


fprintf('\nWylosowane wartości złączowe: q1 = %.2f°, q2 = %.2f m, q3 = %.2f°, q4 = %.2f°\n', rad2deg(TH1), D2, rad2deg(TH3), rad2deg(TH4))

%% Zadanie proste kinematyki
A1=mA(th1,0,0,0);
A2=mA(0,d2,0,-pi/2);
A3=mA(th3,0,a3,0);
A4=mA(th4,0,0,-pi/2);
A5=mA(pi/2,d5,0,0);
% mnozenie macierzy
T0e=A1*A2*A3*A4*A5;
T03=A1*A2*A3;

p_a=T03*[0;0;0;1];

T3e=A4*A5;
% podstawienie za obrotowe zmienne zlaczowe
% w celu uproszczenia zapisu
T03v=subs(T03,{th1,th3,th4} ,{q1,q3,q4});
% wskazanie zmiennych zlaczowych
% zmienne: th1,th2 i a3 wskazane przez‘1’
zmie=[[1,0,0,0];[0,1,0,0];[1,0,0,0];[1,0,0,0];[0,0,0,0]];
% uproszczona postac wyznaczonych macierzy HT% dla celow interpretacji przez uzytkownika
T03u=zam(zmie,T03v,'q');

T0e_n = double(subs(T0e,{th1,th3,th4,d2},{TH1,TH3,TH4,D2}));

%% Zadanie odwrotne kinematyki

% wektory pw i pa
pw=T0e_n(1:3,3) * d5;
pa=T0e_n(1:3,4) - pw;

% % Etap 2 analitycznie
% syms pq pAx pAy pAz
% pq=[pAx; pAy; pAz];
% 
% 
% Wynik2 = pq == T03(1:3,4)
% AA = solve(Wynik2,[th1 th3, d2],'IgnoreAnalyticConstraints',true)
% 
% TH1a = simplify(AA.th1(1,1))
% TH1b = simplify(AA.th1(2,1))
% 
% TH3a = simplify(AA.th3(1,1))
% TH3b = simplify(AA.th3(2,1))
% 
% D2_1 = simplify(AA.d2(1,1))


% Etap 2 liczbowo
Wynik2 = pa == T03(1:3,4);
AA = solve(Wynik2,[th1 th3, d2],'IgnoreAnalyticConstraints',true);

th1_1 = double(AA.th1(1,1));
th1_2 = double(AA.th1(2,1));

d2_1 = double(AA.d2(1,1));
d2_2 = double(AA.d2(2,1));

th3_1 = double(AA.th3(1,1));
th3_2 = double(AA.th3(2,1));

if th1_1>-pi && th1_1<pi && d2_1>-0.4 && d2_1<-0.1 && th3_1>0 && th3_1<pi
 fprintf('\nPierszy zestaw danych zawiera się założonych zakresach.\n')
else
 fprintf('\nPierszy zestaw danych nie zawiera się założonych zakresach.\n')
end

if th1_2>-pi && th1_2<pi && d2_2>-0.4 && d2_2<-0.1 && th3_2>0 && th3_2<pi
 fprintf('Drugi zestaw danych zawiera się założonych zakresach.\n')
else
 fprintf('Drugi zestaw danych nie zawiera się założonych zakresach.\n')
end

pas_1 = double(subs(p_a,{th1,d2,th3},{th1_1,d2_1,th3_1}));
dpax_1 = round(pa(1) - pas_1(1),10);
dpay_1 = round(pa(2) - pas_1(2),10);
dpaz_1 = round(pa(3) - pas_1(3),10);

pas_2 = double(subs(p_a,{th1,d2,th3},{th1_2,d2_2,th3_2}));
dpax_2 = round(pa(1) - pas_2(1),10);
dpay_2 = round(pa(2) - pas_2(2),10);
dpaz_2 = round(pa(3) - pas_2(3),10);

if dpax_1==0 && dpay_1==0 && dpaz_1==0
 fprintf('\nWektor pa dla zestawu pierszego jest poprawny.\n')
else
 fprintf('\nWektor pa dla zestawu pierszego jest błędny.\n')
end

if dpax_2==0 && dpay_2==0 && dpaz_2==0
 fprintf('Wektor pa dla zestawu drugiego jest poprawny.\n')
else
 fprintf('Wektor pa dla zestawu drugiego jest błędny.\n')
end

%% Etap 3

T03_etap3_zestaw1=subs(T03,{th1,th3,d2},{th1_1,th3_1,d2_1});
X_zestaw1 = T03_etap3_zestaw1(1:3,1:3)'*T0e_n(1:3,1:3);
Y_zestaw1 = T3e(1:3,1:3);
th4_1 = solve(X_zestaw1 == Y_zestaw1);

T03_etap3_zestaw2=subs(T03,{th1,th3,d2},{th1_2,th3_2,d2_2});
X_zestaw2 = T03_etap3_zestaw2(1:3,1:3)'*T0e_n(1:3,1:3);
Y_zestaw2 = T3e(1:3,1:3);
th4_2 = solve(X_zestaw2 == Y_zestaw2);

fprintf('\nWyliczone wartości złączowe, zestaw nr 1: q1 = %.2f°, q2 = %.2f m, q3 = %.2f°, q4 = %.2f°\n', rad2deg(th1_1), d2_1, rad2deg(th3_1), rad2deg(th4_1))
fprintf('Wyliczone wartości złączowe, zestaw nr 2: q1 = %.2f°, q2 = %.2f m, q3 = %.2f°, q4 = %.2f°\n', rad2deg(th1_2), d2_2, rad2deg(th3_2), rad2deg(th4_2))