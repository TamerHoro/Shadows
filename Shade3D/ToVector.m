function [x,y,z] = ToVector(A)
%TOVECTOR  Erzeuge 3 gleich lange Vektoren aus den 3 Spalten einer Matrix
% Beispiel:
%  Eingabe Matrix:
%   0, 10, 20
%   1, 11, 21
%   2, 12, 22
%   3, 13, 23
%
%  Ausgabe:
%   x=(0,1,2,3)
%   y=(10,11,12,13)
%   z=(20,21,22,23)
%

x = A(:,1)
y = A(:,2)
z = A(:,3)
