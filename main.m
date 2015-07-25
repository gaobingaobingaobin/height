clc;
close all;
clear all;

%%�����λ��,��λ��meter
camera1 = [0,0,0];
camera2 = [0,5,0];
camera_focal = 28;
%%��������ݼ�����
sun = [1500,1500,1500];
cloud = [500,500,500];
alph = norm(cloud -camera1);
beta = norm(cloud -camera2);
nC1D = (cloud -camera1)/norm(cloud -camera1);%camera1 collected data
nC2D = (cloud -camera2)/norm(cloud -camera2);%camera2 collected data

%%��һ���������Ƶĸ߶�
cloud = cloudheight(camera1,camera2,nC1D,nC2D);
%ʹ��camera1 sun tracking,���̫����������sun/norm(sun)
nsun = sun/norm(sun);
eHeight = dot(cloud,nsun);
%�����ʱ����Ƭ�и��ƿ������ĵ���3��1��(6��11��),������Ƭ������motion vectorgt_r=6;gt_c=0;40*5+40*0.5=220,40*11+40*0.5=460
%|--|--|--|--|
%|--|--|--|--|
%|--|--|--|--|
%|--|--|--|--|
psun = [200,320];
pcloud= [220,460];%�У�200-240���У�440-480
load focal_angle
r_c=size(focal_angle);
for i=1:r_c(1)
    if focal_angle(i,1)==camera_focal
        camera_angle = (0.5*focal_angle(i,2))*pi/180;
    end
end
%tan(camera_angle)=edge-sun/H'
%tan(�����) �� cloud-sun��H'
%tan(camera_angle)/tan(�����) �� edge��sun/cloud-sun
%                            = pixel(edge-center)/pixel(cloud-center)
tanctos = tan(camera_angle)/(320/norm(pcloud-psun));
cloud_sun = tanctos*eHeight;
rou = cloud_sun/norm(pcloud-psun);%���������ϵ������λmeter/pixel
p_p_angle = asin(dot(nsun,[0,0,1]))
eqsun = eHight*nsun;%��Ч̫�����꣬�൱��̫��������ͬһƽ����
%����rou�͸����ƿ������Ƭ�о���̫����pixel��࣬���Ա����Ʋ��ʵ���˶�����
%(cx,cy,cz)=(eqsun(1)+row*rou,eqsun(2)+col*cos(p_p_angle)*rou,eqsun(3))
%��sun-tracking cameraΪ���ģ�eqsun��ˮƽ��Ĵ�ֱͶӰΪ(eqsun(1),eqsun(2),0)
%(eqsun(1)+row*rou,eqsun(2)+col*cos(p_p_angle)*rou,0)��ˮƽλ���ܵ�Ӱ���λ������



