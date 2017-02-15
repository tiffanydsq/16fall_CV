clear variables
clc
close all

load('../data/aerialseq.mat');
load maskBW
maskBWind=find(maskBW);
[r,c]=ind2sub(size(maskBW),maskBWind);

for i=2:size(frames,3)
    
    tic
    It=im2double(frames(:,:,i-1));
    It1=im2double(frames(:,:,i));
    %     M = LucasKanadeAffine(It, It1);
    mask = SubtractDominantMotion(It, It1);
    %% Refine
        mask= bwselect(mask,c,r,8);
        %     imshow(BW2);
        SE=strel('disk',4,8);%('rectangle',[4 4]);
        mask=imdilate(mask,SE);
        %      SE=strel('rectangle',[6 1]);
        %      mask=imerode(mask,SE);
        SE=strel('rectangle',[1 6]);
        mask=imerode(mask,SE);
        mask= bwareaopen(mask,50);
        % imshow(BW4);
        % imshow(frames(:,:,i));% hold on;        
        % It=zeros(size(It));
        immask1=It;
        immask1(mask>0)=1;
        immask2=It;
        immask2(mask>0)=0;
        immask3=It;
        immask3(mask>0)=0;
        immask(:,:,1)=immask1;
        immask(:,:,2)=immask2;
        immask(:,:,3)=immask3;
        It3d=repmat(It,1,1,3);
        imfused=imfuse(immask,It3d);
        
    %% Display
    imshow(imfused);
    image = getframe(gcf);
    if ismember(i,[30 60 90 120])
        toc
        imwrite(image.cdata,['../results/aerialseqFrame',num2str(i),'.jpg']);
    end
end

close



