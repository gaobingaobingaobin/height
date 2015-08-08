clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%initialize solar farm%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%80inches*40inches--solar panel
camera1 = [0,0,0];%unit:mm
camera2 = [50000,0,0];
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

[sun1,cloud1] = Classify(pc1_1);
[sun2,cloud2] = Classify(pc2_1);

%%result of brutal force
classify_sign = 0;
if classify_sign
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
end

%%mix picture
f_c=round(cloud2(1)-cloud1(1));
f_r=round(cloud2(2)-cloud1(2));
pic = MixPic(pc1_1,pc2_1,f_c,f_r);
imshow(pic);
%以下基于f_c<0,f_r<0
sun2 = [sun2(1)-f_c,sun2(2)-f_r];
c1c2_p = sun2-sun1;
c1c2 = camera2-camera1;
d_pixel=norm(sun1-sun2);%太阳中心的像素差
rou = norm(camera1-camera2)/d_pixel;%mm/pixel
%syms rou theta %不会解方程！
%[rou,theta]=solve(c1c2_p(1)*rou*cos(theta)-c1c2_p(2)*rou*sin(theta)-c1c2(1)...
%   ,c1c2_p(1)*rou*cos(theta)+c1c2_p(2)*rou*sin(theta)-c1c2(2),'rou','theta')

%%motion detect
load f1_1vs2_r
load f1_1vs2_c

