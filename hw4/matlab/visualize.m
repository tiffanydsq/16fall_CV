clear variables;
close all;
clc

% Q2.7 - Todo:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

I1=imread('../data/im1.png');
I2=imread('../data/im2.png');
corresp=load('../data/templeCoords.mat');
load('../data/intrinsics.mat');
load('q2_1.mat');
load('q2_5.mat');

point1(:,1)=corresp.x1;
point1(:,2)=corresp.y1;

point2_NCC=zeros(size(point1));
point2_SSD=zeros(size(point1));
% get p2
for i=1:size(point1,1)
    if mod(i,10)==0 
    end
[point2_SSD(i,1), point2_SSD(i,2)] = epipolarCorrespondence(I1,I2, F, point1(i,1), point1(i,2));
[point2_NCC(i,1), point2_NCC(i,2)] = epipolarCorrespondenceNCC(I1,I2, F, point1(i,1), point1(i,2));
end

M1=K1*[1 0 0 0; 0 1 0 0; 0 0 1 0];
[ P_SSD, error_SSD ] = triangulate(M1, point1, M2, point2_SSD);
[ P_NCC, error_NCC ] = triangulate(M1, point1, M2, point2_NCC);

subplot(1,2,1);
scatter3(P_SSD(:,1),P_SSD(:,2),P_SSD(:,3));
title('SSD');
subplot(1,2,2);
scatter3(P_NCC(:,1),P_NCC(:,2),P_NCC(:,3));
title('NCC');

% save('q2_7.mat','F','M1','M2');

