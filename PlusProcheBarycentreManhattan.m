function classe = PlusProcheBarycentreManhattan(Attributs,num_classe_train,attrs,sel)

      classe = num_classe_train(1);
      Attributs=Attributs(:,sel==1);
      attrs=attrs(sel==1);
      distanceMin =  100000 ;
      for i=1:4
          A = Attributs(num_classe_train==i,:);
          barycentre = mean(A);
         
          d=sum(abs(attrs-barycentre));
          disp(d);
          if d < distanceMin
              classe=i;
              distanceMin = d;
          end
      end
      
      disp('ok');
end
