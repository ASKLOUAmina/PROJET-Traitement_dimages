function Attrs  = AttributsForme(I)
    atrs = regionprops(I,'Centroid','Area','Perimeter','EquivDiameter','MajorAxisLength','MinorAxisLength','Orientation');
    
    
    Attrs = [ atrs.Centroid(1) atrs.Centroid(2) atrs.Area  atrs.Perimeter  atrs.EquivDiameter atrs.MajorAxisLength atrs.MinorAxisLength atrs.Orientation]; 
    
    %[Gx,Gy,Aire,Perimetre, Diametre,Longueur,Largeur,Orientation]
end