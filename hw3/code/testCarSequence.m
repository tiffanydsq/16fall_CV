clear variables
clc
close all

load('../data/carseq.mat');
rect=[60,117,146,152];
width=rect(3)-rect(1)+1;
height=rect(4)-rect(2)+1;
rects=zeros(size(frames,3),4);
rects(1,:)=rect;
for i=2:size(frames,3)
    tic
    It=im2double(frames(:,:,i-1));
    It1=im2double(frames(:,:,i));
    [u,v] = LucasKanadeInverseCompositional(It, It1, rect);
    imshow(frames(:,:,i)), hold on;
    
    rectangle('Position',[rect(1)+round(u),rect(2)+round(v),width,height],'EdgeColor',[1 1 0]); hold off;
    rect=[rect(1)+round(u) rect(2)+round(v) rect(3)+round(u) rect(4)+round(v)];
    rects(i,:)=rect;
    
    drawnow;
    image = getframe(gcf);
    if ismember(i,[2 100 200 300 400]) 
        toc
        imwrite(image.cdata,['../results/carseqFrame',num2str(i),'.jpg']);
    end
end
close
save('../results/carseqrects.mat','rects');

