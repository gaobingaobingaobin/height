clc
close all
camera1 = [0,0,0];
camera2 = [0,5,0];
%%假设的数据及处理
sun = [1500,1500,1500];
cloud = [500,500,500];%motion vector = [1,1];
alph = norm(cloud -camera1);
beta = norm(cloud -camera2);
nC1D = (cloud -camera1)/norm(cloud -camera1);%camera1 collected data
nC2D = (cloud -camera2)/norm(cloud -camera2);%camera2 collected data

%%开始计算
cloud = cloudheight(camera1,camera2,nC1D,nC2D);
%使用camera1 sun tracking,获得太阳方向向量sun
H = (cloud.*sun)/norm(sun);
eHeight = norm(H);
%假设此时在照片中云块在中心点右3下1处
%|--|--|--|--|
%|--|--|--|--|
%|--|--|--|--|
%|--|--|--|--|
