function UMA = UnderMaxArea(I) 
   a  = regionprops(I,'Area');
   max = 0;
   underMax=0;
   %disp([ 'lth : ' int2str(length(a))]);
   for i= 1:length(a)
       if  a(i).Area > max
           max =  a(i).Area;
       end
   end
    for i= 1:length(a)
       if  a(i).Area ~= max && a(i).Area > underMax
           underMax =  a(i).Area;
       end
   end
   UMA = underMax;
end