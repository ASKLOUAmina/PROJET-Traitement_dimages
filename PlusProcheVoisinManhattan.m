function classe = PlusProcheVoisinManhattan(Attributs,num_classe_train,attrs,sel)

      classe = num_classe_train(1);
      Attributs=Attributs(:,sel==1);
      attrs=attrs(sel==1);
      distanceMin = sum( abs(attrs-Attributs(1,:) ) );
      
      for i=1:length(num_classe_train)
          
          
          d=sum( abs(attrs-Attributs(i,:)) );
          disp(d);
          if d < distanceMin
             
              classe=num_classe_train(i);
              distanceMin = d;
          end
      end
end
