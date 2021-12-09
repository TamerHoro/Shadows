function [yMin, yMax, zMin zMax] = Min_Max_LP(y,z,y_Licht,z_Licht,y_O,z_O)
% MIN_MAX_LP berechnet das y,z Minimum und Maximum des Schattens,und y,z
% des Lichtpunktes
%
% Eingabe:
%    y,z Koordinaten des Schattens ,
%    y,z Koordinaten des Lichtes: _Licht
%    y,z Koordinaten des Objektes: _O
%
% Ausgabe:
%   gesamt y,z Minimum und Maximum


% ABFRAGE OB AKTUELLER WERT KLEINER ODER GRÖßER IST UND DIESEN DANN
% ENTSPRECHEN SPEICHERN

yMin = y_Licht * (and(y_Licht <= min(y),y_Licht <= min(y_O)))... 
        + min(y) * (and(min(y) < y_Licht,min(y) <= min(y_O)))...
        + min(y_O) * (and(min(y_O) <= y_Licht , min(y_O) < min(y)))

yMax = y_Licht * (and(y_Licht >= max(y),y_Licht >= max(y_O)))...
        + max(y) * (and(max(y) > y_Licht,max(y) >= max(y_O)))...
        + max(y_O) * (and(max(y_O) >= y_Licht, max(y_O) > max(y)))
    
zMin = z_Licht * (and(z_Licht <= min(z),z_Licht <= min(z_O)))...
        + min(z) * (and(min(z) < z_Licht, min(z) <= min(z_O)))...
        + min(z_O) * (and(min(z_O) <= z_Licht, min(z_O) < min(z)))
    
zMax = z_Licht * (and(z_Licht >= max(z),z_Licht >= max(z_O)))...
        + max(z) * (and(max(z) >= z_Licht,max(z) > max(z_O)))...
        + max(z_O) * (and(max(z_O) > z_Licht,max(z_O) >= max(z)))
