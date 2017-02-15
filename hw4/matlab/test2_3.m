clear variables;
close all;
clc

I1=imread('../data/im1.png');
I2=imread('../data/im2.png');
corresp=load('../data/some_corresp.mat');
pts1=corresp.pts1;
pts2=corresp.pts2;
M=max(size(I1,1),size(I1,2));
% imshow(pts1);
F= eightpoint( pts1, pts2, M );
% displayEpipolarF(I1,I2,F);
load('../data/intrinsics.mat');
E = essentialMatrix( F, K1, K2 );
[U,S,V]=svd(E);
r9=[0,-1,0;1 0 0;0 0 1];
r_9=[0,1,0;-1 0 0;0 0 1];
t=U(:,3);

if det(U*r9'*V)==1
    R1=U*r9'*V;
else
    R1=-U*r9'*V;
end
if det(U*r_9'*V')==1
    R2=U*r_9'*V';
else
    R2=-U*r_9'*V';
end

M1=[1 0 0 0; 0 1 0 0; 0 0 1 0];
% M2=M2s(:,:,i);
M2_1=[R1,t];
[ P1, error1 ] = triangulate( M1, pts1, M2_1, pts2 );

M2_2=[R2,t];
[ P2, error2 ] = triangulate( M1, pts1, M2_2, pts2 );

% M2=[1 0 0 0; 0 1 0 0; 0 0 1 0];

