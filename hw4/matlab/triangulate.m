function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%

% [pi]x*M*P=0
P=zeros(size(p1,1),4);
for i=1:size(p1,1)
p1x=[0 -1 p1(i,2); 1 0 -p1(i,1); -p1(i,2) p1(i,1) 0];
p2x=[0 -1 p2(i,2); 1 0 -p2(i,1); -p2(i,2) p2(i,1) 0];
pM=[p1x*M1; p2x*M2];
[~,~,V]=svd(pM);
P(i,:)=V(:,end)/V(end,end);
end

p1h=P*M1';
pe1=p1h(:,1:2)./repmat(p1h(:,3),1,2);
p2h=P*M2';
pe2=p2h(:,1:2)./repmat(p2h(:,3),1,2);
error=sum(sum(((p1-pe1).^2+(p2-pe2).^2)));
P=P(:,1:3);
end
