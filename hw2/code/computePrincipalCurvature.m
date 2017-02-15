function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% inputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each point contains the curvature ratio R for the 
% 					   corresponding point in the DoG pyramid

PrincipalCurvature=zeros(size(DoGPyramid));
for i=1:size(DoGPyramid,3)
    [Dx,Dy]=gradient(DoGPyramid(:,:,i));
    [Dxx,Dxy]=gradient(Dx);
    [Dyx,Dyy]=gradient(Dy);
    for r=1:size(DoGPyramid,1)
        for c=1:size(DoGPyramid,2)
            H=[Dxx(r,c) Dxy(r,c); Dyx(r,c) Dyy(r,c)];
            R=(trace(H))^2/det(H);
            PrincipalCurvature(r,c,i)=R;
        end
    end
end