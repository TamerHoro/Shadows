function P = ToMatrix(x,y,z)
%TOMATRIX  Erzeuge eine Matrix aus 3 gleich langen Vektoren
% Beispiel:
%  Eingabe:
%   x=(0,1,2,3)
%   y=(10,11,12,13)
%   z=(20,21,22,23)
%
%  Ausgabe Matrix:
%   0, 10, 20
%   1, 11, 21
%   2, 12, 22
%   3, 13, 23


l = length(x);

P = zeros(l,3);
P(:,1) = x
P(:,2) = y
P(:,3) = z
