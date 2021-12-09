function [yMin, yMax, zMin zMax] = Y_Z_ExtremePoints_Lightpoint(y,z,y_Licht,z_Licht)

L = length(y)
yMin = y_Licht*(min(y)<y_licht) + min(y)*(min(y)<y_licht)
yMax = y_Licht
zMin = z_Licht
zMax = z_Licht
for i = 1:1:L
    %Min Max abfragen y 
    if min(y)<yMin
        yMin=min(y)
    end;
    if max(y)>yMax
        yMax = max(y)
    end;
    
    % Min Max abfrage z
    
    if min(z)<zMin
        zMin=z(i)
    end;
    if max(z)>zMax
        zMax = z(i)
    end;
end;
    