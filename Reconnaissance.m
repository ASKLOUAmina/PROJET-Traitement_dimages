clear all;
close all;
clc;

nb_classe = 4; % défini le nombre de classes
nb_image = 30; % défini le nombre d'images par classe
chemin = './Base/';
nb_ima = nb_classe*nb_image;
nb_ima_train = nb_ima/6;	
% pour chaque classe, seul un objet sur 6 est utilisé pour l'apprentissage
Attributs = zeros(nb_ima_train,8);

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

        % Conversion en niveaux de gris
        Ima_gray = rgb2gray(Ima_train);
				
        % Ajouter ici si nécessaire des opérations de prétraitement
        [N_region,RGB,Ima_traitee] = Pretraitement(Ima_gray);
        
        % Extraction des attributs de forme
        Attributs(ima_label,:) = AttributsForme(Ima_traitee);  
    end
end

train_time = toc;
%%

figure;
scatter(Attributs(:,3),Attributs(:,8),4*num_classe_train,num_classe_train,'filled');
title('Avant de centrer et réduire les attributs');
xlabel(PropName(3));
ylabel(PropName(8));



%% 

for i=1:8
    m(i)=mean(Attributs(:,i));
    ect(i) = std(Attributs(:,i));
    Attributs(:,i) = (Attributs(:,i)-m(i) )/ect(i)
end

%% 

figure;
scatter(Attributs(:,3),Attributs(:,8),4*num_classe_train,num_classe_train,'filled');
title('Après avoir centré et réduit les attributs');
xlabel(PropName(3));
ylabel(PropName(8));



%% 

figure;
n=1;
title('Nuages de points dont les coordonnées sont deux des attributs calculés');

for i=1:4
    for j=i+1:7
        subplot(4,7,n)
        scatter(Attributs(:,i),Attributs(:,j),4*num_classe_train,num_classe_train,'filled');
       
        xlabel(PropName(i));

        ylabel(PropName(j));
        n=n+1;

    end
end

%% 


%% 
figure;
subplot(2,2,1)
scatter(Attributs(:,3),Attributs(:,6),4*num_classe_train,num_classe_train,'filled');
xlabel(PropName(3));
ylabel(PropName(6));

subplot(2,2,2)
scatter(Attributs(:,5),Attributs(:,6),4*num_classe_train,num_classe_train,'filled');
xlabel(PropName(5));
ylabel(PropName(6));


subplot(2,2,3)
scatter(Attributs(:,1),Attributs(:,3),4*num_classe_train,num_classe_train,'filled');
xlabel(PropName(1));
ylabel(PropName(3));

subplot(2,2,4)
scatter(Attributs(:,6),Attributs(:,7),4*num_classe_train,num_classe_train,'filled');
xlabel(PropName(6));
ylabel(PropName(7));
       
        





%% 
%Décision
tic
nb_ima_test = nb_ima-nb_ima_train;
Attributs_test = zeros(nb_ima_test,8);
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
        
        % Conversion en niveaux de gris
        Ima_gray = rgb2gray(Ima_test);
        
        [N_region,RGB,Ima_traitee] = Pretraitement(Ima_gray);
        
        Attributs_test(ima_label,:) = AttributsForme(Ima_traitee);
        
     end
end

for i=1:8
    Attributs_test(:,i) = (Attributs_test(:,i)-m(i) )/ect(i);
end



%% 
%Décision suite

classe_prediction=0;
for i=1:nb_ima_test
    
     %Le dernier argument permet la sélection d'attribut, 0 à une position veut dit attribut ignoré
     
     classe_prediction(i) = PlusProcheVoisin(Attributs,num_classe_train,Attributs_test(i,:),[1,1,1,1,1,1,1,1]); 
     %classe_prediction(i)= PlusProcheVoisinManhattan(Attributs,num_classe_train,Attributs_test(i,:),[1,1,1,1,1,1,1,1]); 
     %classe_prediction(i) = PlusProcheBarycentre(Attributs,num_classe_train,Attributs_test(i,:),[1,1,1,1,1,1,1,1]); 
     %classe_prediction(i) = PlusProcheBarycentreManhattan(Attributs,num_classe_train,Attributs_test(i,:),[1,1,0,1,1,1,1,1]); 

end

test_time=toc;
duree_total= train_time+test_time;
taux = sum(num_classe_test==classe_prediction)/ima_label * 100;
disp(['Taux de classification : ' int2str(taux) '%']);
disp(['Durée totale : ' int2str(duree_total)]);


C = confusionmat(num_classe_test,classe_prediction);
disp(C);



