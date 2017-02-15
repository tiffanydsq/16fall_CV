clear variables
clc
close all

load('../data/usseq.mat');
rect=[255,105,310,170];
width=rect(3)-rect(1)+1;
height=rect(4)-rect(2)+1;

rects=zeros(size(frames,3),4);
rects(1,:)=rect;
for i=2:size(frames,3)
    tic
    It=im2double(frames(:,:,i-1));
    It1=im2double(frames(:,:,i));
    [u,v] = LucasKanadeInverseCompositional(It, It1, rect);
    % [u,v] = LucasKanade00(It, It1, rect);
    imshow(frames(:,:,i)), hold on;
    % px=px+round(u);
    % py=py+round(v);
    rectangle('Position',[rect(1)+round(u),rect(2)+round(v),width,height],'EdgeColor',[1 1 0]); hold off;
    rect=[rect(1)+round(u) rect(2)+round(v) rect(3)+round(u) rect(4)+round(v)];
    rects(i,:)=rect;
    
    drawnow;
    image = getframe(gcf);
    if ismember(i,[5 25 50 75 100])
        toc
        imwrite(image.cdata,['../results/usseqFrame',num2str(i),'.jpg']);
%         Elapsed time is 0.086497 seconds.
%         Elapsed time is 0.081142 seconds.
%         Elapsed time is 0.078864 seconds.
%         Elapsed time is 0.065418 seconds.
    end
end
close
save('../results/usseqrects.mat','rects');

