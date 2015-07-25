clc;
close all;
clear all;

%%相机的位置,单位：meter
camera1 = [0,0,0];
camera2 = [0,5,0];
camera_focal = 28;
%%假设的数据及处理
sun = [1500,1500,1500];
cloud = [500,500,500];
alph = norm(cloud -camera1);
beta = norm(cloud -camera2);
nC1D = (cloud -camera1)/norm(cloud -camera1);%camera1 collected data
nC2D = (cloud -camera2)/norm(cloud -camera2);%camera2 collected data

%%第一步，计算云的高度
cloud = cloudheight(camera1,camera2,nC1D,nC2D);
%使用camera1 sun tracking,获得太阳方向向量sun/norm(sun)
nsun = sun/norm(sun);
eHeight = dot(cloud,nsun);
%假设此时在照片中该云块在中心点右3下1处(6行11列),两张照片检测出的motion vectorgt_r=6;gt_c=0;40*5+40*0.5=220,40*11+40*0.5=460
%|--|--|--|--|
%|--|--|--|--|
%|--|--|--|--|
%|--|--|--|--|
psun = [200,320];
pcloud= [220,460];%行：200-240；列：440-480
load focal_angle
r_c=size(focal_angle);
for i=1:r_c(1)
    if focal_angle(i,1)==camera_focal
        camera_angle = (0.5*focal_angle(i,2))*pi/180;
    end
end
%tan(camera_angle)=edge-sun/H'
%tan(二面角) ＝ cloud-sun／H'
%tan(camera_angle)/tan(二面角) ＝ edge－sun/cloud-sun
%                            = pixel(edge-center)/pixel(cloud-center)
tanctos = tan(camera_angle)/(320/norm(pcloud-psun));
cloud_sun = tanctos*eHeight;
rou = cloud_sun/norm(pcloud-psun);%计算出比例系数；单位meter/pixel
p_p_angle = asin(dot(nsun,[0,0,1]))
eqsun = eHight*nsun;%等效太阳坐标，相当于太阳和云在同一平面上
%利用rou和各个云块的在照片中距离太阳的pixel差距，可以表达出云层的实际运动趋势
%(cx,cy,cz)=(eqsun(1)+row*rou,eqsun(2)+col*cos(p_p_angle)*rou,eqsun(3))
%以sun-tracking camera为中心，eqsun在水平面的垂直投影为(eqsun(1),eqsun(2),0)
%(eqsun(1)+row*rou,eqsun(2)+col*cos(p_p_angle)*rou,0)是水平位置受到影响的位置坐标



