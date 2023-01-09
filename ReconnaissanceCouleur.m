clear all;
close all;
clc;

nb_classe = 4; % défini le nombre de classes
nb_image = 30; % défini le nombre d'images par classe
chemin = './Base/';
nb_ima = nb_classe*nb_image;
nb_ima_train = nb_ima/6;	
% pour chaque classe, seul un objet sur 6 est utilisé pour l'apprentissage
Attributs = zeros(nb_ima_train,24);

%% Apprentisage
ima_label=0;
tic ;
for i_train=1:nb_ima
    if (((1<=i_train)&&(i_train<=5))||((31<=i_train)&&(i_train<=35))||((61<=i_train)&&(i_train<=65))||((91<=i_train)&&(i_train<=95)))
        ima_label=ima_label+1;
        % Enregistrement du numéro de la classe dans un tableau
        num_classe_train(ima_label) = floor((i_train-1)/nb_image) + 1;
        
        % Concaténaion des chaînes de caractères pour constituer le chemain d'accès au fichier image
        fichier_train = Filename(i_train);
       
        % Affichage du numéro de la classe
        disp([fichier_train ' Classe '  int2str(num_classe_train(ima_label))]);

        % Ouverture de l'image
        Ima_train = imread(fichier_train);
        

        % Composantes
        Ima_R = Ima_train(:,:,1);
        Ima_G = Ima_train(:,:,2);
        Ima_B = Ima_train(:,:,3);
        		
        % Ajouter ici si nécessaire des opérations de prétraitement
        [N_region,RGB,Ima_traitee_R] = Pretraitement(Ima_R);
        [N_region,RGB,Ima_traitee_G] = Pretraitement(Ima_G);
        [N_region,RGB,Ima_traitee_B] = Pretraitement(Ima_B);
		
        
        % Extraction des attributs de forme
        att_R = AttributsForme(Ima_traitee_R);
        att_G = AttributsForme(Ima_traitee_G);
        att_B = AttributsForme(Ima_traitee_B);
        Attributs(ima_label,:) = [att_R att_G att_B];  
    end
end

train_time = toc;



%% 

for i=1:24
    m(i)=mean(Attributs(:,i));
    ect(i) = std(Attributs(:,i));
    Attributs(:,i) = (Attributs(:,i)-m(i) )/ect(i)
end


%% 

nb_ima_test = nb_ima-nb_ima_train;
Attributs_test = zeros(nb_ima_test,24);
ima_label=0;
num_classe_test=zeros(1,nb_ima_test);
for i_test=1:nb_ima
    
    if (((6<=i_test)&&(i_test<=30))||((36<=i_test)&&(i_test<=60))||((66<=i_test)&&(i_test<=90))||((96<=i_test)&&(i_test<=120)))
      %if (((1<=i_test)&&(i_test<=5))||((31<=i_test)&&(i_test<=35))||((61<=i_test)&&(i_test<=65))||((91<=i_test)&&(i_test<=95)))
        ima_label=ima_label+1; 
       
        % Enregistrement du numéro de la classe dans un tableau
        num_classe_test(ima_label) = floor((i_test-1)/nb_image) + 1;
        
        % Concaténaion des chaînes de caractères pour constituer le chemain d'accès au fichier image
        fichier_test = Filename(i_test);
     
        % Ouverture de l'image
        Ima_test = imread(fichier_test);
        
         % Composantes
        Ima_R = Ima_test(:,:,1);
        Ima_G = Ima_test(:,:,2);
        Ima_B = Ima_test(:,:,3);
        		
        % Ajouter ici si nécessaire des opérations de prétraitement
        [N_region,RGB,Ima_traitee_R] = Pretraitement(Ima_R);
        [N_region,RGB,Ima_traitee_G] = Pretraitement(Ima_G);
        [N_region,RGB,Ima_traitee_B] = Pretraitement(Ima_B);
		
        
        % Extraction des attributs de forme
        att_R = AttributsForme(Ima_traitee_R);
        att_G = AttributsForme(Ima_traitee_G);
        att_B = AttributsForme(Ima_traitee_B);
        
        Attributs_test(ima_label,:) = [att_R att_G att_B]; 
        
  
     end
end

for i=1:24
    Attributs_test(:,i) = (Attributs_test(:,i)-m(i) )/ect(i);
end



%% 
%Décision
tic
classe_prediction=0;
for i=1:nb_ima_test
        classe_prediction(i) = PlusProcheVoisin(Attributs,num_classe_train,Attributs_test(i,:), ones(1,24)); 
        %classe_prediction(i)= PlusProcheVoisinManhattan(Attributs,num_classe_train,Attributs_test(i,:), ones(1,24)); 
        %classe_prediction(i) = PlusProcheBarycentre(Attributs,num_classe_train,Attributs_test(i,:), ones(1,24));
        %classe_prediction(i) = PlusProcheBarycentreManhattan(Attributs,num_classe_train,Attributs_test(i,:),ones(1,24)); 

end

test_time=toc;
duree_total= train_time+test_time;
taux = sum(num_classe_test==classe_prediction)/ima_label * 100;
disp(['Taux de classification : ' int2str(taux) '%']);
disp(['Durée totale : ' int2str(duree_total)]);

C = confusionmat(num_classe_test,classe_prediction);
disp(C);

