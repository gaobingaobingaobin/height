
%I=imread('s&c.jpg');
I=pic;
level = graythresh(I);
Ibw=im2bw(I,level);
figure(1);imshow(Ibw);
Ibw=imfill(Ibw,'holes');
Ibw=bwareaopen(Ibw,90);
figure(2);imshow(Ibw);
hold on;
[L,m]=bwlabel(Ibw,8);
stats=regionprops(L,'Centroid');
for i=1:m
    plot(stats(i).Centroid(1),stats(i).Centroid(2),'R+');
end
hold off;