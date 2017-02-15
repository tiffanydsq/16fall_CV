function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
%
% To prevent clipping at the edges, we instead need to warp both image 1 and image 2 into a common third reference frame 
% in which we can display both images without any clipping.

%warp_img = warpH(img2, H2to1, size(img1));

%warp_im = warpH(im, H, out_size,fill_value)
%panoImg = (1-(1-blendratio1).*warp_mask).*img1+(1-blendratio1).*warp_mask.*warp_img;
% blendratio=0.5;



%figure(1)

%imshow(warp_img1);

%figure(2)
% warp_img2 = warpH(img2, M*H2to1, outsize);
%imshow(warp_img2);
%figure(3)

%% Masks
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



%% Get out outsize and M
M=[1 0 0;0 1 0; 0 0 1]; 
%{
width1=size(img1,2);
height1=size(img1,1);
width2=size(img2,2);
height2=size(img2,1);
corner2=[width2,width2;0,height2;1,1];
corner2t=H2to1*corner2;
corner2t(:,1)=round(corner2t(:,1)./corner2t(3,1));
corner2t(:,2)=round(corner2t(:,2)./corner2t(3,2));
dr1=abs(min(corner2t(2,1),0));
dr2=max(corner2t(2,2))-height1;
dc=max(corner2t(:,1))-width1;
outsize(1)=max+dr1+dr2;
outsize(2)=width1+dc+20;
%}

topleft1=[1 1];
bottomleft1=[1 size(img1,1)];
topright1=[size(img1,2) 1];
bottomright1=[size(img1,2) size(img1,1)];

topleft20=[1 1 1];
topleft2=(H2to1*topleft20')';
topleft2=topleft2./topleft2(3);

topright20=[size(img2,2) 1 1];
topright2=(H2to1*topright20')';
topright2=topright2./topright2(3);

bottomleft20=[1 size(img2,1) 1];
bottomleft2=(H2to1*bottomleft20')';
bottomleft2=bottomleft2./bottomleft2(3);

bottomright20=[size(img2,2) size(img2,1) 1];
bottomright2=(H2to1*bottomright20')';
bottomright2=bottomright2./bottomright2(3);

% corner2t=H2to1*corner2;
top=min([topleft1(2) topright1(2) topleft2(2) topright2(2) bottomleft1(2) bottomright1(2) bottomleft2(2) bottomright2(2)]);
bottom=max([topleft1(2) topright1(2) topleft2(2) topright2(2) bottomleft1(2) bottomright1(2) bottomleft2(2) bottomright2(2)]);
left=min([topleft1(1) topleft2(1) bottomleft1(1) bottomleft2(1) topright1(1) topright2(1) bottomright1(1) bottomright2(1)]);
right=max([topright1(1) topright2(1) bottomright1(1) bottomright2(1) topright1(1) topright2(1) bottomright1(1) bottomright2(1)]);

outsize(1)=ceil(bottom-top);
outsize(2)=ceil(right-left);
M(1,3)=(min([topleft1(2) bottomleft1(2)])-left);
M(2,3)=(min([topleft1(1) topright1(2)])-top);

warp_img1 = warpH(img1, M, outsize);
warp_mask1=warpH(immask1, M, outsize);
warp_img2 = warpH(img2, M*H2to1, outsize);
warp_mask2 = warpH(immask2,  M*H2to1, outsize);

%{
for r=1:outsize(1)
    for c=2:outsize(2)
        if (warp_img1(r,c,1)==0) && (warp_img2(r,c,1)~=0  )
            warp_img1(r,c,:)=warp_img2(r,c,:);
        elseif (warp_img1(r,c,1)~=0) && (warp_img2(r,c,1)==0 ) 
                warp_img2(r,c,:)=warp_img1(r,c,:);
        end     
    end
end
%}
panoImg = (warp_mask1.*warp_img1+warp_mask2.*warp_img2)./(warp_mask1+warp_mask2);
%final2=warp_mask.*warp_img2;
%imshow(final2);

end
