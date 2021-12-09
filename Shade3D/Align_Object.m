function [px,py,pz] = Align_Object(x,y,z,a)
%ALIGN_OBJECT richtet ein Objekt(x,y,z) vor der y-z-Ebene aus,
% mit einem übergebeben abstand a zu dieser Ebene 
% Der Mittelpunkt liegt über der x-Achse
% zusätzlich liegt der niedrigste punkt auf y = 0 
%
%  Eingabe:
%    Koordinaten des Körpers x,y,z
%    Abstand zur Ebene a
%
%  Ausgabe:
%    Koordinaten des Ausgerichteten Objektes:
%         px,py,pz


%Mittelpunktberechnung

t2 = length(y);
t3 = length(z);
b= sum(y)/t2;
c= sum(z)/t3;

% VERSCHIEBUNGSVEKTOR

VMX = a - min(x);
VMY = 0 - b ;
VMZ = 0 - c;

% NEUE PUNKTE BERECHNEN MIT DEM VERSCHIEBUNGSVEKTOR

px = x + VMX
py = y + VMY
pz = z + VMZ

% NIEDRIGSTEN PUNKT (Z-KOORDINATEN -MINIMUM) AUF 0 SETZEN

nz = min(pz)
pz = pz - nz;
