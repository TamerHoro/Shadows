function [a,b,c] = Object_Center(x,y,z)
%OBJECT_CENTER liest alle Koordinaten x,y,z ein und berechnet den
%Mittelpunkt von diesem Objekt
%
%  Eingabe:
%    Liste der x,y,z Koordinaten
%  
%  Ausgabe:
%    MittelPunkt M Koordinaten a,b,c


t1 = length(x);
t2 = length(y);
t3 = length(z);

a= sum(x)/t1;
b= sum(y)/t2;
c= sum(z)/t3;