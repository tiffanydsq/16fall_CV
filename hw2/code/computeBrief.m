function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareA, compareB,patchWidth)
%%Compute Brief feature
% input
% im - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors
%
% output
% locs - an m x 3 vector, where the first two columns are the image coordinates of keypoints and the third column is
%		 the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of valid descriptors in the image and will vary

drA=floor((compareA-1)./patchWidth)-4;
dcA=mod(compareA-1,9)-4;

drB=floor((compareB-1)./patchWidth)-4;
dcB=mod(compareB-1,9)-4;

%[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
%locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,th_contrast, th_r)
edge=floor(patchWidth/2);
nbits=length(compareA);
count=0;
for idx=1:size(locsDoG,1)
    centerR=locsDoG(idx,2);
    centerC=locsDoG(idx,1);
    if (centerC>edge) && (centerC< (size(im,2)-edge+1)) && (centerR>edge) && (centerR< (size(im,1)-edge+1))
        count=count+1;
        locs(count,1)=centerC;
        locs(count,2)=centerR;
        locs(count,3)=locsDoG(idx,3);
        ar=centerR+drA;
        ac=centerC+dcA;
        br=centerR+drB;
        bc=centerC+dcB;
        for i=1:nbits
        desc(count,i)=GaussianPyramid(ar(i),ac(i),locsDoG(idx,3)==levels)<GaussianPyramid(br(i),bc(i),locsDoG(idx,3)==levels);
        end
    end
end



