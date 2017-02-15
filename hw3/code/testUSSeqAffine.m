clear variables
clc
close all

load('../data/usseq.mat');
load('../results/usseqrects.mat');


for i=2:size(frames,3)
    
    tic
    maskBW=zeros(size(frames(:,:,1)));
    rect=rects(i,:);
    width=rect(3)-rect(1);
    height=rect(4)-rect(2);
    maskBW(rect(2):rect(4),rect(1):rect(3))=1;

    maskBWind=find(maskBW);
    [r,c]=ind2sub(size(maskBW),maskBWind);
    It=im2double(frames(:,:,i-1));
    It1=im2double(frames(:,:,i));

    mask = SubtractDominantMotion(It, It1);
    
    %% Refine
        mask= bwselect(mask,c,r,8);
        %     imshow(BW2);
        SE=strel('disk',3,8);%('rectangle',[4 4]);
        mask=imdilate(mask,SE);
        %      SE=strel('rectangle',[6 1]);
        %      mask=imerode(mask,SE);
        SE=strel('rectangle',[3 3]);
        mask=imerode(mask,SE);
        mask= bwareaopen(mask,50);
        % imshow(BW4);
        % imshow(frames(:,:,i));% hold on;
        % It=zeros(size(It));
        immask1=It;
        immask1(mask>0)=0.5;
        immask2=It;
        immask2(mask>0)=0;
        immask3=It;
        immask3(mask>0)=0;
        immask(:,:,1)=maskBW.*immask1+(1-maskBW).*It;
        immask(:,:,2)=maskBW.*immask2+(1-maskBW).*It;
        immask(:,:,3)=maskBW.*immask3+(1-maskBW).*It;
        It3d=repmat(It,1,1,3);
        imfused=imfuse(immask,It3d);
    
    %% Display
    imshow(imfused);
    image = getframe(gcf);
    if ismember(i,[2 25 50 75 100])
        toc
        imwrite(image.cdata,['../results/usseqAffineFrame',num2str(i),'.jpg']);
    end
end

close



