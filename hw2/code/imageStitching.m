function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image



    % Mask1
mask1=zeros(size(img1,1),size(img1,2));
mask1(1,:)=1;
mask1(end,:)=1;
mask1(:,1)=1;
mask1(:,end)=1;
mask1=bwdist(mask1,'city');
mask1=mask1/max(mask1(:));
immask1=repmat(mask1,[1 1 3]);
    % Mask2
mask2=zeros(size(img2,1),size(img2,2));
mask2(1,:)=1;
mask2(end,:)=1;
mask2(:,1)=1;
mask2(:,end)=1;
mask2=bwdist(mask2,'city');
mask2=mask2/max(mask2(:));
immask2=repmat(mask2,[1 1 3]);
    % Warped Mask
warp_img = warpH(img2, H2to1, size(img1));
warp_mask = warpH(immask2, H2to1, size(img1));
panoImg = (immask1.*img1+warp_mask.*warp_img)./(immask1+warp_mask);
%imshow(warp_mask.*warp_img./(immask+warp_mask))%(warp_mask.*warp_img)
%illu=(immask1+warp_mask)./(immask1+warp_mask);
%imshow(illu)

