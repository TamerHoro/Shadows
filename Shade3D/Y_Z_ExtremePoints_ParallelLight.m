function [yMin, yMax, zMin, zMax] = Y_Z_ExtremePoints_ParallelLight(y,z,y_Min_Object,y_Max_Object,z_Min_Object,z_Max_Object)

L = length(y)
yMin = y_Min_Object
yMax = y_Max_Object
zMin = z_Min_Object
zMax = z_Max_Object
for i = 1:1:L
    %Min Max abfragen y 
    if y(i)<yMin
        yMin=y(i)
    end;
    if y(i)>yMax
        yMax = y(i)
    end;
    
    % Min Max abfrage z
    
    if z(i)<zMin
        zMin=z(i)
    end;
    if z(i)>zMax
        zMax = z(i)
    end;
end;
    