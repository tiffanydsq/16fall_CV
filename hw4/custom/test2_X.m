close all
clear variables
clc

I1=imread('../data/im1.png');
I2=imread('../data/im2.png');
corresp=load('../data/some_corresp_noisy.mat');
%corresp=load('../data/some_corresp.mat');
pts1=corresp.pts1;
pts2=corresp.pts2;
M=max(size(I1,1),size(I2,2));
F= ransacF( pts1, pts2, M );
displayEpipolarF(I1,I2,F);



