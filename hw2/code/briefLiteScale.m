function [locs, Desc] = briefLiteScale(im)
% input
% im - gray image with values between 0 and 1
%
% output
% locs - an m x 3 vector, where the first two columns are the image coordinates of keypoints and the third column 
% 		 is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. 
%		 m is the number of valid descriptors in the image and will vary
% 		 n is the number of bits for the BRIEF descriptor

% load Parameters
sigma0=1;
th_contrast=0.03;
th_r=12;
k=2^(1/2);
levels=-1:10; %[-1 0 1 2 3 4];
patchWidth=9;

% nbits=256;

[locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r);
%[compareA, compareB] = makeTestPattern(patchWidth, nbits);
%save('testPattern.mat','compareA','compareB'); 
load('testPattern.mat','compareA','compareB'); 
% load ('testPattern.mat','compareB'); 
% load ('compareAr'); 
%for i=size(compareA,1)
[locs,Desc] = computeBriefScale(im, GaussianPyramid, locsDoG, k, levels, compareA, compareB,patchWidth);
%end

end


