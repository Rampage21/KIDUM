function [q1 q2 q3 q4] = losowanie_q
q1 = deg2rad(rand*360-180);
q2 = -rand*0.3-0.1;
q3 = deg2rad(rand*180);
q4 = deg2rad(-rand*180);
end