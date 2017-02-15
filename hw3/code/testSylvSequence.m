clear variables
clc
close all

load('../data/sylvbases.mat');
load('../data/sylvseq.mat');
rect=[102,62,156,108];
width=rect(3)-rect(1)+1;
height=rect(4)-rect(2)+1;
rects=zeros(size(frames,3),4);
rects(1,:)=rect;
rect0=rect;
for i=2:size(frames,3)
    tic
    It=im2double(frames(:,:,i-1));
    It1=im2double(frames(:,:,i));
    [u,v] = LucasKanadeBasis(It, It1, rect,bases);
    [u0,v0] = LucasKanadeInverseCompositional(It, It1, rect0);
    imshow(frames(:,:,i)), hold on;
    rectangle('Position',[rect0(1)+round(u0),rect0(2)+round(v0),width,height],'EdgeColor',[0 1 0]); %hold off;
    rectangle('Position',[rect(1)+round(u),rect(2)+round(v),width,height],'EdgeColor',[1 1 0]); hold off;
    rect=[rect(1)+round(u) rect(2)+round(v) rect(3)+round(u) rect(4)+round(v)];
    rect0=[rect0(1)+round(u0) rect0(2)+round(v0) rect0(3)+round(u0) rect0(4)+round(v0)];
    rects(i,:)=rect;
    drawnow;
    image = getframe(gcf);
    if ismember(i,[2 200 300 350 400])
        toc
        imwrite(image.cdata,['../results/sylvseqFrame',num2str(i),'.jpg']);
    end
end
close
save('../results/sylvseqrects.mat','rects');

