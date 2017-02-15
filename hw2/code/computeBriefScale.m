function [locs,Desc] = computeBriefScale(im, GaussianPyramid, locsDoG, k, levels, compareA, compareB,patchWidth)
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

% ind2sub
[orA,ocA]=ind2sub([9 9],compareA);
orA=orA-5;
ocA=ocA-5;
% =floor((compareA-1)./patchWidth)-4;
% =mod(compareA-1,9)-4;
[orB,ocB]=ind2sub([9 9],compareB);
orB=orB-5;
ocB=ocB-5;
% orB=floor((compareB-1)./patchWidth)-4;
% ocB=mod(compareB-1,9)-4;
PI=3.14159;
count=0;

for scale=levels(2:end) %*rand(1,30)
    %for i=1:round(360/RotationInterval)
    %theta=RotationInterval*i;
%    degree=theta/180*PI;
    degree=0;
    R=[cos(degree) -sin(degree); sin(degree) cos(degree)];
    
    posA=R*[ocA;orA];
    dcA=posA(1,:);
    drA=posA(2,:);
    
    posB=R*[ocB;orB];
    dcB=posB(1,:);
    drB=posB(2,:);
    
    %[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
    %locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,th_contrast, th_r)
    edge=floor(patchWidth*k^scale/2);
    %     nbits=length(compareA);
    
    for idx=1:size(locsDoG,1)
        centerR=locsDoG(idx,2);
        centerC=locsDoG(idx,1);
        if (centerC>edge) && (centerC< (size(im,2)-edge+1)) && (centerR>edge) && (centerR< (size(im,1)-edge+1))
            count=count+1;
            locs(count,1)=centerC;
            locs(count,2)=centerR;
            locs(count,3)=locsDoG(idx,3);
            %scale=k^ScaleImg;

            ar=centerR+drA*k^scale;
            ac=centerC+dcA*k^scale;
            br=centerR+drB*k^scale;
            bc=centerC+dcB*k^scale;
            layer=GaussianPyramid(:,:,locsDoG(idx,3)==levels);
            positionA=interp2(layer,ac,ar, 'bicubic');
            positionB=interp2(layer,bc,br, 'bicubic');
            Desc(count,:)=positionA<positionB;

        end
    end
   
end
