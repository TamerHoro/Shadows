function [LichtX,LichtY,LichtZ] = Centralprojection_Shadow(x,y,z,lx,ly,lz)
%CENTRALPROJECTION_SHADOW führt eine Zentralprojektion von einem Punkt über 
% ein Objekt auf die y,z Ebene aus 
% Berechnung im Handbuch , Kapitel Mathematisches Modell berechnet 
%
%
%   Eingabe:
%     zu Projezierende Punkte x,y,z 
%     Lichtpunkt/Augenpunkt
% 
%   Ausgabe:
%      Projezierte Punkte Koordinaten x,y,z in Vektor Form

l = length(x);
LichtX = zeros(1,l);
LichtY = zeros(1,l);
LichtZ = zeros(1,l);


%BERECHNUNG SIEHE HANDBUCH
%vx,vy,vz  "STEIGUNGSVEKTOR KOORDINATEN"

for i = 1:1:l
    vx =   x(i) - lx;
    vy =   y(i) - ly;
    vz =   z(i) - lz;
    t = -x(i)/(vx);                             
    LichtY(i) = y(i) + t*vy ;
    LichtZ(i) = z(i) + t*vz ;
    LichtX(i) = 0;
end;
    

    