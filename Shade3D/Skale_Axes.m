function [X_Max,Y_Min,Y_Max,Z_Min,Z_Max] = Skale_Axes(x_max,y_Min,y_Max,z_Min,z_Max)
%SKALE_AXES skaliert die Axen so, dass der Schatten und das Objekt auf dem
%Plot nicht verzerrt angezeigt werden ,bzw. und alle Punkte angezeigt
%werden
%
% Eingabe:
%   x,y,z Maxima & y,z Minimum (Min x = 0)
%
% Ausgabe:
%   x,y,z Maxima & y,z Minimum (unverzerrtes Bild )

y_distance = y_Max - y_Min;
z_distance = z_Max -z_Min;


% ABFRAGE WELCHE DISTANZ AM GRÖßTEN UND NACH DER GRÖ?E DANN AUSRICHTEN

if and(x_max>=y_distance,x_max>=z_distance)
    y_diffrence = (x_max-y_distance)/2;
    z_diffrence = (x_max-z_distance)/2;
    X_Max = x_max;
    Y_Min = y_Min - y_diffrence;
    Y_Max = y_Max + y_diffrence;
    Z_Min = z_Min - z_diffrence;
    Z_Max = z_Max + z_diffrence;
end;

if and(y_distance >= x_max,y_distance >= z_distance)
    z_diffrence = (y_distance-z_distance)/2;
    X_Max = y_distance;
    Y_Min = y_Min;
    Y_Max = y_Max;
    Z_Min = z_Min - z_diffrence;
    Z_Max = z_Max + z_diffrence;
end;

if and(z_distance >= x_max,z_distance >= y_distance )
    y_diffrence = (z_distance-y_distance)/2;
    X_Max = z_distance;
    Z_Min = z_Min;
    Z_Max = z_Max;
    Y_Min = y_Min - y_diffrence;
    Y_Max = y_Max + y_diffrence;
end;