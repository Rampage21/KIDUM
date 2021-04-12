function [pa, wynik] = wyniki(y)
d5=0.2;
syms Q1 Q2 Q3
pw = simplify(y(1:3,3)*d5); % wektor pw
P = simplify(y(1:3,4)); % wektor P
pa = simplify(P-pw);
rownanie = pa == y(1:3,8);
wynik = solve(rownanie, [Q1 Q2 Q3],'IgnoreAnalyticConstraints',true);
end