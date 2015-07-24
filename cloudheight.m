function [cloud] = cloudheight(camera1,camera2,nC1D,nC2D)
%camera1->position vector,camera2->position vector
C1C2 = camera2 - camera1;
%解模长方程
%C1C2 = beta*nC2D- alph*nC1D; 
%[alph,beta] = solve('beta*nC2D(1)-alph*nC1D(1)=C1C2(1)','beta*nC2D(2)-alph*nC1D(2)=C1C2(2)','alph','beta')
alph = (C1C2(1)*nC2D(2) - C1C2(2)*nC2D(1))/(nC1D(1)*nC2D(2) - nC1D(2)*nC2D(1));
beta = (C1C2(1)*nC1D(2) - C1C2(2)*nC1D(1))/(nC1D(1)*nC2D(2) - nC1D(2)*nC2D(1));
cloud = camera1 + alph*nC1D;
%获得太阳高度cloud(3)