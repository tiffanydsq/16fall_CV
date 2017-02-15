function im3 =generatePanorama(im1, im2)

im10=im1;
im20=im2;
if size(im1,3)~=1
    im1=rgb2gray(im1);
end
if size(im2,3)~=1
    im2=rgb2gray(im2);
end

tic
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
[matches] = briefMatch(desc1, desc2);
toc

nIter=500;
tol=1;

tic
bestH = ransacH(matches, locs1, locs2, nIter, tol);
toc

im3 = imageStitching_noClip(im10, im20, bestH);
%figure(2)
%imshow(panoImg);
