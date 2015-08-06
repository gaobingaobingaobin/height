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
pc1_1 = imread('f1_1.jpg');
pc2_1 = imread('f2_1.jpg');
pc1_2 = imread('f1_2.jpg');

seg_num = 40;
%result of brutal force
load f12_c
load f12_r
[m,n]=size (gt_c);
count=0;sum_c=0;sum_r=0;
t_c = abs(gt_c);
t_r = abs(gt_r);
for i=1:m
    for j=1:n
        if t_c(i,j)>2||t_r(i,j)>2
            count = count+1;
            sum_c = sum_c+gt_c(i,j);
            sum_r = sum_r+gt_r(i,j);
        end
    end
end
f_c=round(sum_c/count);
f_r=round(sum_r/count);
pic = MixPic(pc1_1,pc2_1,f_c,f_r);
%pic = MixPic(pc2_1,pc1_1,9,f_r);debug
imshow(pic);
%̫���ľ����d_pixel=
rou = norm(camera1-camera2)/d_pixel;



%%
if 0
    ps=imread('sun.jpg'); %��ȡͼ��
    subplot(1,3,1)
    imshow(ps);
    title('ԭͼ��');
    ps=rgb2gray(ps);
    [m,n]=size(ps); %��Sobel΢�����ӽ��б�Ե���
    pa = edge(ps,'sobel');
    subplot(1,3,2);
    imshow(pa);
    title('Sobel��Ե���õ���ͼ��');
    pp = edge(ps,'canny');
    subplot(1,3,3);
    imshow(pp);
    end