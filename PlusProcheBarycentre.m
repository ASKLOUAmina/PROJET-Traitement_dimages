function classe = PlusProcheBarycentre(Attributs,num_classe_train,attrs,sel)

      classe = num_classe_train(1);
      Attributs=Attributs(:,sel==1);
      attrs=attrs(sel==1);
      distanceMin =  10000 ;
      for i=1:4
          A = Attributs(num_classe_train==i,:);
          barycentre = mean(A);
         
          d=sqrt(sum( (attrs-barycentre).^2 ));
          disp(d);
          if d < distanceMin
              classe=i;
              distanceMin = d;
          end
      end
      
      disp('ok');
end
