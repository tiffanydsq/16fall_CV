close all
clear variables
clc

I1=imread('../data/im1.png');
I2=imread('../data/im2.png');
% save('corresp2_2.mat','pts1','pts2'); 
% cpselect(I1,I2);
load corresp2_2.mat
M=max(size(pts1,1),size(pts1,2));
F= sevenpoint( pts1, pts2, M );
% F=F{2}{1}
% displayEpipolarF(I1,I2,F);
save('q2_2.mat','F','M','pts1','pts2'); % in function

