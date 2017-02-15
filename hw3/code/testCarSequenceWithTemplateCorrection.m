clear variables
clc
close all

load('../data/carseq.mat');
rect=[60,117,146,152];
width=rect(3)-rect(1)+1;
height=rect(4)-rect(2)+1;
rects=zeros(size(frames,3),4);
rects(1,:)=rect;
p=[0 0];
pn=[0 0];
It=im2double(frames(:,:,1));
% rectX=rect(1):rect(3);
% rectY=rect(2):rect(4);
T1=It;%(rectY,rectX);
T=T1;
k=1;
for i=2:size(frames,3)
    tic
    %     It=im2double(frames(:,:,i-1));
    It1=im2double(frames(:,:,i));
    [u,v] = LucasKanadeInverseCompositionalTemplate(T, It1, rects(k,:),pn);
    pn=[u,v];
    pstar = LucasKanadeInverseCompositionalTemplate(T1, It1, rect,pn+p);
    if norm(pn+p-pstar)<0.01
        T=It1;
        p=pstar;
        pn=[0 0];
        k=i;
    end
    imshow(frames(:,:,i)), hold on;
    rect = rects(k,:);
    rectangle('Position',[rect(1)+round(u),rect(2)+round(v),width,height],'EdgeColor',[1 1 0]); hold on;
    rect=[rect(1)+round(u) rect(2)+round(v) rect(3)+round(u) rect(4)+round(v)];
    rects(i,:)=rect;
    rectstemp=rects;
    load('../results/carseqrects.mat','rects');
    rectoriginal=rects;    
    rectangle('Position',[rectoriginal(i,1),rectoriginal(i,2),width,height],'EdgeColor',[0 1 0]); hold off;    
    rects=rectstemp;
    drawnow;
    image = getframe(gcf);
    if ismember(i,[2 100 200 300 400])
        toc
        imwrite(image.cdata,['../results/carseq-wcrtFrame',num2str(i),'.jpg']);
    end
end
close
save('../results/carseqrects-wcrt.mat','rects');


