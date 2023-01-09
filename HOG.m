clear;
close all;
clc

I=imread('Base\000002.png');
%figure,
%imshow(I);

%niveau de gris

I_ndg= im2gray(I);


% question 20 extractHOGFeatures

[featureVector,hogVisualization] = extractHOGFeatures(I_ndg);
figure;
imshow(I_ndg); 
hold on;
plot(hogVisualization);
title('utilisation de extractHOGFeatures');


% question 21 extractHOGFeatures vizualisation
[hog1,visualization] = extractHOGFeatures(I_ndg,'CellSize',[128 128]);
figure;
subplot(1,2,1);
imshow(I_ndg);
subplot(1,2,2);
plot(visualization);
title('extractHOGFeatures vizualisation');

% question 22 variation de CellSize

[hog2,visualization] = extractHOGFeatures(I_ndg,'CellSize',[70 70]); %le nombre de hog augmente
figure;
subplot(1,2,1);
imshow(I_ndg);
subplot(1,2,2);
plot(visualization);
title('variation de CellSize');




