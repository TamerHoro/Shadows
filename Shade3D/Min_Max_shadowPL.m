function [yMin, yMax, zMin, zMax] = Min_Max_shadowPL(y,z,y_Min_Object,y_Max_Object,z_Min_Object,z_Max_Object)
%MIN_MAX_SHADOWPL gibt die größte und kleinste y,z Koordinate des
%Systems,mit Parallelen Licht,zurück
%
% Eingabe:
%    y,z Koordinaten des Schattens ,
%    y,z Minimum und Maximum
%
% Ausgabe:
%   gesamt y,z Minimum und Maximum


% ABFRAGE OB AKTUELLER WERT KLEINER ODER GRÖßER IST UND DIESEN DANN
% ENTSPRECHEN SPEICHERN

yMin = y_Min_Object * (y_Min_Object <= min(y)) + min(y) * (min(y) < y_Min_Object)
yMax = y_Max_Object * (y_Max_Object >= max(y)) + max(y) * (max(y) > y_Max_Object)
zMin = z_Min_Object * (z_Min_Object <= min(z)) + min(z) * (min(z) < z_Min_Object)
zMax = z_Max_Object * (z_Max_Object >= max(z)) + max(z) * (max(z) > z_Max_Object)

