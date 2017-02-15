clear variables;
close all;
clc

I1=im2double(imread('../data/im1.png'));
I2=im2double(imread('../data/im2.png'));
load('../data/intrinsics.mat');
load('q2_1.mat');
load('q2_5.mat');

% Get index
im1=rgb2gray(I1);
M=max(size(I1,1),size(I1,2));
%{
count=0;
tic
for x=1:size(im1,2) %x
    for y=1:size(im1,1) %y
        if im1(y,x)>0.2
            count=count+1;
            if mod(count,1000)==0
                count
                toc
            end
            x1(count)=x;
            y1(count)=y;
            im1color(count,:)=I1(y,x,:);
%             [ x2(count), y2(count) ] = epipolarCorrespondence( I1, I2, F, x, y );
        end
    end
end
%}
M1=K1*[1 0 0 0; 0 1 0 0; 0 0 1 0];
load q3X.mat;
[ P, error ] = triangulate( M1, [x1',y1'], M2, [x2',y2'] );
% P=P./repmat(P(:,3),1,3);

% save('q3X.mat','x2','y2','P','im1color','x1','y1');

C1 = interp2(I1(:,:,1), x1',y1');
C2 = interp2(I1(:,:,2), x1',y1');
C3 = interp2(I1(:,:,3), x1',y1');
C=cat(2,C1,C2,C3);
scatter3(P(:,1), P(:,2), P(:,3), 10, C, 'o','fill');

