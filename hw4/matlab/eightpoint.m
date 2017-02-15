function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'

corresp1=pts1/M;
corresp2=pts2/M;
%Uf=0
U=zeros(size(corresp1,1),9);
U(:,1)=corresp2(:,1).*corresp1(:,1); % x2 x1
U(:,2)=corresp2(:,1).*corresp1(:,2); % x2 y1
U(:,3)=corresp2(:,1); % x2
U(:,4)=corresp2(:,2).*corresp1(:,1); % y2 x1
U(:,5)=corresp2(:,2).*corresp1(:,2); % y2 y1
U(:,6)=corresp2(:,2); % y2
U(:,7)=corresp1(:,1); % x1
U(:,8)=corresp1(:,2); % y1
U(:,9)=1;

[~,~,V]=svd(U'*U);
v=V(:,9);
F=reshape(v,[3 3])';
[UF,SF,VF]=svd(F);
SF(3,3)=0;
F=UF*SF*VF';
F = refineF(F,corresp1,corresp2);
% unscale F
assert(det(F)<1e-10);
T=[1/M 0 0;0 1/M 0;0 0 1];
% W=[corresp1,ones(size(corresp1,1));
F=T'*F*T;
%     Save F, M, pts1, pts2 to q2_1.mat
% save('q2_1.mat','F','M','pts1','pts2');
%     Write F and display the output of displayEpipolarF in your writeup

end

