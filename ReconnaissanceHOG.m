clear all;
close all;
clc;

nb_classe = 4; % défini le nombre de classes
nb_image = 30; % défini le nombre d'images par classe
chemin = 'Base\';
nb_ima = nb_classe*nb_image;
nb_ima_train = nb_ima/6;	
% pour chaque classe, seul un objet sur 6 est utilisé pour l'apprentissage
Attributs = zeros(nb_ima_train, 2268);
%Attributs = zeros(nb_ima_train, 7956);
%Attributs = zeros(nb_ima_train, 720);
%Attributs = zeros(nb_ima_train, 48708);

%% Apprentisage
ima_label=0;
tic;
for i_train=1:nb_ima
    if (((1<=i_train)&&(i_train<=5))||((31<=i_train)&&(i_train<=35))||((61<=i_train)&&(i_train<=65))||((91<=i_train)&&(i_train<=95)))
        ima_label=ima_label+1;
        % Enregistrement du numéro de la classe dans un tableau
        num_classe_train(ima_label) = floor((i_train-1)/nb_image) + 1;
        
        % pour constituer le chemain d'accès au fichier image
        fichier_train = Filename(i_train);
        
        % Affichage du numéro de la classe
        disp([fichier_train ' Classe '  int2str(num_classe_train(ima_label))]);

        % Ouverture de l'image
        Ima_train = imread(fichier_train);

        % Conversion en niveaux de gris
        Ima_gray = im2gray(Ima_train);
        
        % Extraction des attributs de forme
        
        Attributs(ima_label,:) = extractHOGFeatures(Ima_gray,'CellSize',[128 128]);  
        %Attributs(ima_label,:) = extractHOGFeatures(Ima_gray,'CellSize',[70 70]);
        %Attributs(ima_label,:) = extractHOGFeatures(Ima_gray,'CellSize',[200 200]);
        %Attributs(ima_label,:) = extractHOGFeatures(Ima_gray,'CellSize',[70 70]);
        %Attributs(ima_label,:) = extractHOGFeatures(Ima_gray,'CellSize',[30 30]);
    end
end

train_time = toc;

 
%Question 23

ima_label=0;
cp=0;
   tic 
for i_train=1:nb_ima
    if (((6<=i_train)&&(i_train<=30))||((36<=i_train)&&(i_train<=60))||((66<=i_train)&&(i_train<=90))||((96<=i_train)&&(i_train<=120)))
        ima_label=ima_label+1;
        % classe réel
        num_classe_test(ima_label) = floor((i_train-1)/nb_image) + 1;
        
        
        % pour constituer le chemain d'accès au fichier image
        fichier_train = Filename(i_train);
        % Affichage du numéro de la classe
        disp(fichier_train);

        % Ouverture de l'image
        Ima_train = imread(fichier_train);

        % Conversion en niveaux de gris
        Ima_gray = im2gray(Ima_train);
		
        res(ima_label,:) = extractHOGFeatures(Ima_gray,'CellSize',[128 128]);  
        %res(ima_label,:) = extractHOGFeatures(Ima_gray,'CellSize',[70 70]);
        %res(ima_label,:) = extractHOGFeatures(Ima_gray,'CellSize',[200 200]);
        %res(ima_label,:) = extractHOGFeatures(Ima_gray,'CellSize',[30 30]);
                
    end
end

  
  
  
%% 
%D�cision
nb_ima_test = nb_ima-nb_ima_train;
classe_prediction=0;
for i=1:nb_ima_test
        classe_prediction(i) = PlusProcheVoisin(Attributs,num_classe_train,res(i,:),ones(1,2268));
        %classe_prediction(i) = PlusProcheVoisinManhattan(Attributs,num_classe_train,res(i,:),[1,1,1,1,1,1,1,1]);
         %classe_prediction(i) = PlusProcheBarycentre(Attributs,num_classe_train,res(i,:),[1,1,1,1,1,1,1,1]);
end

test_time=toc;
duree_total= train_time+test_time;
taux = sum(num_classe_test==classe_prediction)/ima_label * 100;
disp(['Taux de classification : ' int2str(taux) '%']);
disp(['Dur�e totale : ' int2str(duree_total)]);

C = confusionmat(num_classe_test,classe_prediction);
disp(C);