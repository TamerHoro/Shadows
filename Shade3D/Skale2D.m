function [yMin ,yMax, zMin, zMax] = Skale2D(y_Min ,y_Max, z_Min, z_Max)
%SKALE2D skaliert die Axen so, dass der Schatten und das Objekt auf dem
%Plot nicht verzerrt angezeigt werden ,bzw. und alle Punkte angezeigt
%werden
%
% Eingabe:
%   y,z - Maxima, Minimum 
%
% Ausgabe:
%   y,z Maxima & y,z Minimum( unverzerrtes Bild)


y_distance = y_Max - y_Min;
z_distance = z_Max -z_Min;
yMin = y_Min;
yMax = y_Max;
zMin = z_Min;
zMax = z_Max;

if(y_distance > z_distance)
    z_diffrence = (y_distance-z_distance)/2;
    zMin = z_Min -z_diffrence;
    zMax = z_Max + z_diffrence;
end;

if(z_distance > y_distance)
    y_diffrence = (z_distance-y_distance)/2;
    yMin = y_Min -y_diffrence;
    yMax = y_Max + y_diffrence;
end;