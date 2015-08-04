clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%initialize solar farm%%%%%%%%%%%%%%%%%%%%%%%%%
camera1 = [0,0,0];%unit:mm
camera2 = [0,50000,0];
k=0;m=0;
for i=1:100
    m=m+1;
    for j=1:100
        k=k+1;
        cell(m,k,:) = [i*150,j*150,0];
    end
    k=0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%initialize rbg picture%%%%%%%%%%%%%%%%%%%%%%%%%
pc1_1 = imread('f1.jpg');
pc2_1 = imread('f2.jpg');
pc1_2 = imread('f3.jpg');

%pc1_1=rgb2gray(pc1_1);
%pc2_1=rgb2gray(pc2_1);
%pc1_2=rgb2gray(pc1_2);
%imshow(pc1_1)

seg_num = 40;
%result of brutal force
load f12_c
load f12_r
[m n]=size (gt_c);
count=0;
for i=1:m
    for j=1:n
        if (gt_c(i,j)~=0||gt_c(i,j)~=0)
            count = count+1;
        end
    end
end
f_c=round(sum(sum(gt_c))/count);
f_r=round(sum(sum(gt_r))/count);
d_pixel = sqrt(f_c^2+f_r^2);
rou = norm(camera1-camera2)/d_pixel;
ps=imread('sun.jpg'); %读取图像
subplot(1,3,1)
imshow(ps);
title('原图像');
ps=rgb2gray(ps);
[m,n]=size(ps); %用Sobel微分算子进行边缘检测
pa = edge(ps,'sobel');
subplot(1,3,2);
imshow(pa);
title('Sobel边缘检测得到的图像');
pp = edge(ps,'canny');
subplot(1,3,3);
imshow(pp);
