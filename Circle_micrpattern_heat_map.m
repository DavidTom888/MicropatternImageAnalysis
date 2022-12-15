close all
clear all
clc

%change path to where you want the images to be saved
%select all the input images

[filename1,pathname1,filterindex1]=uigetfile('*.TIF','Pick a file','MultiSelect','on');
m=length(filename1);

S=uint32(imread(strcat(pathname1,filename1{1})));



for p=2:m
    S=imadd(S,uint32(imread(strcat(pathname1,filename1{p}))));
        
end

S=imdivide(S,m);
SG=mat2gray(S);
SG=rgb2gray(SG)*3.3456;
figure,imshow(SG);

%if it gives you an error because the matrices are not the same size it is
%because one of the patterns was too close to the border and the crop
%was larger than the image size and did not work
%in this case, decrease crop or eliminate that image


p=100; % p indicate percentage divided
rr=300; % 300 for 600 um pattern 10x, 250 for 500 um pattern, 10x, 400 for 800 um pattern, 200 for 400 um pattern, 300 for 300 um pattern, 20x
n=size(S,1);
%R=zeros(1,n/2);
aQ=zeros(1,p);
pix=1.072; %0.645 for 10x, 4 for traction force


for t=linspace(1,p,p) % 10% to 100% distance
    sum=0; m=0;
for x=1:n
    for y=1:n
        if sqrt((x-n/2)^2+(y-n/2)^2)<=t/p*rr/pix && sqrt((x-n/2)^2+(y-n/2)^2)>=(t/p-1/p)*rr/pix
            

sum=sum+SG(x,y);
m=m+1;
        end
    end
end
aQ(1,t)=sum/m;
end

XX=linspace(rr/p,rr,p);% for 20x obj, use rr/2, otherwise, use rr
figure, plot(XX,aQ,'-o')
ax=gca;
ax.XTick=0:rr/10:rr; %rr/20 for 20x obj, otherwise, use rr/10
