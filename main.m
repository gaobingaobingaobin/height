clc
close all
camera1 = [0,0,0];
camera2 = [0,5,0];
%%��������ݼ�����
sun = [1500,1500,1500];
cloud = [500,500,500];%motion vector = [1,1];
alph = norm(cloud -camera1);
beta = norm(cloud -camera2);
nC1D = (cloud -camera1)/norm(cloud -camera1);%camera1 collected data
nC2D = (cloud -camera2)/norm(cloud -camera2);%camera2 collected data

%%��ʼ����
cloud = cloudheight(camera1,camera2,nC1D,nC2D);
%ʹ��camera1 sun tracking,���̫����������sun
H = (cloud.*sun)/norm(sun);
eHeight = norm(H);
%�����ʱ����Ƭ���ƿ������ĵ���3��1��
%|--|--|--|--|
%|--|--|--|--|
%|--|--|--|--|
%|--|--|--|--|
