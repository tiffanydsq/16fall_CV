function H2to1 = computeH(p2,p1)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
N=size(p1,2);
u=p1(1,:)';
v=p1(2,:)';
x=p2(1,:)';
y=p2(2,:)';
A(1:N,1)=-u;
A(1:N,2)=-v;
A(1:N,3)=-1;
A(1:N,4:6)=0;
A(1:N,7)=x.*u;
A(1:N,8)=x.*v;
A(1:N,9)=x;
A(N+1:2*N,1:3)=0;
A(N+1:2*N,4)=-u;
A(N+1:2*N,5)=-v;
A(N+1:2*N,6)=-1;
A(N+1:2*N,7)=y.*u;
A(N+1:2*N,8)=y.*v;
A(N+1:2*N,9)=y;

[U,S,V] = svd(A);
%[U2,S2,V2] =svd((A')*A);
h=V(:,end);
H2to1(1,:)=h(1:3);
H2to1(2,:)=h(4:6);
H2to1(3,:)=h(7:9);

%A*h
%eig() or svd()
