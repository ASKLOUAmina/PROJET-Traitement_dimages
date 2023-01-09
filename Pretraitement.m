function [ N, RGB,It ] = Pretraitement(I)
  
    I_bw = im2bw(I,graythresh(I));
    I_bw = ~I_bw;

    %Parfaire la segmentation%
    %I_p1 = imfill(I_bw,'holes');
    I_p2 = bwareaopen(I_bw,50);
    I_p3 = imdilate(I_p2,strel('disk',10));
    I_p4 = imerode(I_p3,strel('disk',10));
    
    %I_p4 = imfill(I_p3,'holes');
    
    [L,n] = bwlabel(I_p4);
    
    if( n ~= 1) 
        a=UnderMaxArea(I_p4);
        I_p4 = bwareaopen(I_p4,a+1 );
    end
    [L,n] = bwlabel(I_p4);
    N=n;
    
    RGB = label2rgb(L);
    It=I_p4;

end