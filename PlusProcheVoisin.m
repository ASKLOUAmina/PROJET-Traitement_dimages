function classe = PlusProcheVoisin(Attributs,num_classe_train,attrs,sel)

      classe = num_classe_train(1);
      %Attributs=Attributs(:,sel==1);
      %attrs=attrs(sel==1);
      distanceMin = sqrt(sum((attrs-Attributs(1,:)).^2)); %on fixe à 1ère distance
      
      for i=1:length(num_classe_train)
          d=sqrt(sum( (attrs-Attributs(i,:)).^2 ));
          disp(d);
          if d < distanceMin
             
              classe=num_classe_train(i);
              distanceMin = d;
          end
      end
end
