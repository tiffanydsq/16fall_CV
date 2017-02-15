clear variables;
close all;
clc

% [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 );

I1=imread('../data/im1.png');
I2=imread('../data/im2.png');
corresp=load('../data/some_corresp.mat');
pts1=corresp.pts1;
pts2=corresp.pts2;
M=max(size(I1,1),size(I1,2));
% imshow(pts1);
F= eightpoint( pts1, pts2, M );

[pts1, pts2] = epipolarMatchGUI(I1, I2, F);
%Save F, pts1, and pts2 used to generate view to q2_6.mat
% save('q2_6.mat','F','pts1','pts2');

