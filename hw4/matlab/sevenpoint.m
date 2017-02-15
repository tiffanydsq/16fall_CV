function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
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
v1=V(:,8);
v2=V(:,9);
F1=reshape(v1,[3 3])';
F2=reshape(v2,[3 3])';

syms lambda
F=(1-lambda)*F1+lambda*F2;
S=double(solve(det(F)==0));
S=real(S(imag(S)<1e-10)); 

F=cell(length(S),1);

T=[1/M 0 0;0 1/M 0;0 0 1];

for i=1:length(S)
    temp=(1-S(i))*F1+S(i)*F2;
    [U,SS,V]=svd(temp);
    SS(3,3)=0;
    Temp= refineF(U*SS*V',corresp1,corresp2);
    F{i}=T'*Temp*T;
end

% Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat
% save('q2_2.mat','F','M','pts1','pts2');
%     Write recovered F and display the output of displayEpipolarF in your writeup

end

