function [Sonnex,Sonney] = Parallelprojection_Shadow(x,y,w)
%CENTRALPROJECTION_SHADOW führt eine Parallelprojektion mit einem Winkel w 
% über ein Objekt auf die y,z Ebene aus 
% Berechnung im Handbuch , Kapitel Mathematisches Modell berechnet 
% Hier 
%
%   Eingabe:
%     zu Projezierende Punkte x,y,z 
%     winkel w
% 
%   Ausgabe:
%      Projezierte Punkte Koordinaten x,y,z in Vektor Form

m=tan(w);  
l= length(y);
t = zeros(1,l);

% BERECHNUNG SIEHE HANDBUCH

for i = 1:1:l
    t(i)=((-x(i))*m)+y(i);
end;

Sonney=t ;
Sonnex=zeros(1,l);

