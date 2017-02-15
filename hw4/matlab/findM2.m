clear variables;
close all;
clc

% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, p1, p2, R and P to q2_5.mat

I1=imread('../data/im1.png');
I2=imread('../data/im2.png');
corresp=load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
pts1=corresp.pts1;
pts2=corresp.pts2;
M=max(size(I1,1),size(I1,2));
F= eightpoint( pts1, pts2, M );
% displayEpipolarF(I1,I2,F);
E = essentialMatrix( F, K1, K2 );
M2s = camera2(E);
M1=K1*[1 0 0 0; 0 1 0 0; 0 0 1 0];

for i=1:4
    M2test=M2s(:,:,i);
    nvec=M2test(:,1:3)*[0 0 1]';%-M2(:,4)';
    M2test=K2*M2test;
    [ Pall, error(i) ] = triangulate(M1, pts1,M2test, pts2 );

    if nvec'*(Pall(:,1:3)'-repmat(M2test(:,4),1,size(Pall,1)))>0
        P=Pall(:,1:3);
        M2=M2test;
%         break;
    end
end

% Save mat
p1=pts1;
p2=pts2;
% save('q2_5.mat','M2','p1','p2','P');

