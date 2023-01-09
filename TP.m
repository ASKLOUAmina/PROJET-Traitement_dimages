clear all;
close all
clc ;

nb_classe = 4;
nb_image = 30; % par classe
chemin='./Base/';

nb_ima = nb_classe*nb_image;
N = zeros(1,nb_ima);

for i=1:nb_ima
    %[n,RGB] = Pretraitement(imread(Filename(i)));
    %N(1,i)=n;
end

nb_ones = length( N(N==1));

I = imread(Filename(115));
I_gray = rgb2gray(I);
I_bw = im2bw(I_gray,graythresh(I));
I_bw_inv = ~I_bw;

%Parfaire la segmentation%
I_p1 = imfill(I_bw_inv,'holes');
I_p2 = bwareaopen(I_p1,50);
I_p3 = imdilate(I_p2,strel('disk',10));
I_p4 = imerode(I_p3,strel('disk',10));

I_p5 = imfill(I_p4,'holes');


 [L,n] = bwlabel(I_p5);
  
 RGB = label2rgb(L);
%imshow(I_p3);

figure;
subplot(2,4,1); imshow(I); title('Image RGB');
subplot(2,4,2); imshow(I_gray); title('Niveau de gris');
subplot(2,4,3); imshow(I_bw); title('Binaire');
subplot(2,4,4); imshow(I_bw_inv); title('Binaire inversé');
subplot(2,4,5); imshow(I_p1); title('Imfill');
subplot(2,4,6); imshow(I_p2); title(' bwareaopen');
subplot(2,4,7); imshow(I_p3); title('imdilate');
subplot(2,4,8); imshow(I_p4); title('imerode');

figure;
subplot(1,2,1);imshow(I);title('Image RGB')
subplot(1,2,2);imshow(RGB);title('L’analyse en composantes connexes')
    

%clear si plus d'une region

%recuperer la surface de la plus grande surface parasite( la deuxième plus
%vaste des regions)
a=UnderMaxArea(I_p4);

%On supprime alors les regions est en dessous de a+1
%On aurra finalement une région
I_p5 = bwareaopen(I_p4,a+1 );
figure;
imshow(I_p5);title('Regions parasites enlevées');
 
 
%42,116,117

%[N1,RGB,It] = Pretraitement(I);
%imshow(RGB);
%Att = AttributsForme(It);
%disp(size(Att))

%% 
I = imread(Filename(100));

figure;
subplot(2,3,2); imshow(I); title('Image RGB');
subplot(2,3,4); imshow(I(:,:,1)); title('Composant R');
subplot(2,3,5); imshow(I(:,:,2)); title('Composant G');
subplot(2,3,6); imshow(I(:,:,3)); title('Composant B');



